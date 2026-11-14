import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String id;
  final String name;
  final String description;
  final String lastMessage;
  final String? image;
  final int color_backgroung_icon;
  final int nummessage;
  final DateTime? date;
  final String? time;
  final String category;
  final DateTime? datecreateChat;
  final String? wallpaper;
  final bool boolNotification;
  final bool boolIsPin;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool deleted;
  final String? pendingImagePath;

  const ChatModel({
    required this.id,
    required this.name,
    required this.description,
    this.lastMessage = '',
    this.image,
    required this.color_backgroung_icon,
    required this.nummessage,
    this.date,
    this.time,
    required this.category,
    this.datecreateChat,
    this.wallpaper,
    this.boolNotification = true,
    this.boolIsPin = false,
    this.createdAt,
    this.updatedAt,
    this.deleted = false,
    this.pendingImagePath,
  });

  String? get displayImage {
    if (pendingImagePath != null && pendingImagePath!.isNotEmpty) {
      return pendingImagePath;
    }
    return image;
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      if (value is Timestamp) return value.toDate();
      if (value is DateTime) return value;
      if (value is String) return DateTime.tryParse(value);
      if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
      return null;
    }

    int parseInt(dynamic value, [int fallback = 0]) {
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? fallback;
      return fallback;
    }

    bool parseBool(dynamic value, [bool fallback = false]) {
      if (value is bool) return value;
      if (value is String) return value.toLowerCase() == 'true';
      return fallback;
    }

    final rawImage = json['image'] as String? ??
        json['image_or_icon'] as String? ??
        json['iconUrl'] as String?;
    final lastMsg =
        json['lastMessage'] as String? ?? json['description'] as String? ?? '';
    final chatName = json['name'] as String? ?? json['title'] as String? ?? '';
    final isPinned = parseBool(json['boolIsPin'] ?? json['isPinned'], false);
    final numMsg = parseInt(json['nummessage'] ?? json['uncompletedCount']);
    final createdDate = parseDate(
      json['datecreateChat'] ?? json['createdAt'] ?? json['updatedAt'],
    );
    final updatedDate = parseDate(json['updatedAt']) ?? createdDate;

    return ChatModel(
      id: json['id'] as String? ?? '',
      name: chatName,
      description: json['description'] as String? ?? '',
      lastMessage: lastMsg,
      image: rawImage,
      color_backgroung_icon: parseInt(json['color_backgroung_icon']),
      nummessage: numMsg,
      date: parseDate(json['date']),
      time: json['time'] as String?,
      category: json['category'] as String? ?? 'all',
      datecreateChat: createdDate,
      wallpaper: json['wallpaper'] as String?,
      boolNotification: parseBool(json['boolNotification'], true),
      boolIsPin: isPinned,
      createdAt: createdDate,
      updatedAt: updatedDate,
      deleted: parseBool(json['deleted'], false),
      pendingImagePath: json['pendingImagePath'] as String?,
    );
  }

  factory ChatModel.fromHiveMap(Map<dynamic, dynamic> map) {
    DateTime? parseMillis(dynamic value) {
      if (value == null) return null;
      if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
      if (value is String) {
        final parsed = int.tryParse(value);
        if (parsed != null) return DateTime.fromMillisecondsSinceEpoch(parsed);
        return DateTime.tryParse(value);
      }
      return null;
    }

    int parseInt(dynamic value, [int fallback = 0]) {
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? fallback;
      return fallback;
    }

    bool parseBool(dynamic value, [bool fallback = false]) {
      if (value is bool) return value;
      if (value is String) return value.toLowerCase() == 'true';
      return fallback;
    }

    final createdDate = parseMillis(map['createdAt']) ??
        parseMillis(map['datecreateChat']) ??
        parseMillis(map['updatedAt']);

    return ChatModel(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      lastMessage: map['lastMessage']?.toString() ?? '',
      image: map['image']?.toString(),
      color_backgroung_icon: parseInt(map['color_backgroung_icon']),
      nummessage: parseInt(map['nummessage']),
      date: parseMillis(map['date']),
      time: map['time']?.toString(),
      category: map['category']?.toString() ?? 'all',
      datecreateChat: createdDate,
      wallpaper: map['wallpaper']?.toString(),
      boolNotification: parseBool(map['boolNotification'], true),
      boolIsPin: parseBool(map['boolIsPin'], false),
      createdAt: createdDate,
      updatedAt: parseMillis(map['updatedAt']) ?? createdDate,
      deleted: parseBool(map['deleted'], false),
      pendingImagePath: map['pendingImagePath']?.toString(),
    );
  }

  Map<String, dynamic> toHiveMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'lastMessage': lastMessage,
      'image': image,
      'color_backgroung_icon': color_backgroung_icon,
      'nummessage': nummessage,
      'date': date?.millisecondsSinceEpoch,
      'time': time,
      'category': category,
      'datecreateChat': (datecreateChat ?? createdAt)?.millisecondsSinceEpoch,
      'wallpaper': wallpaper,
      'boolNotification': boolNotification,
      'boolIsPin': boolIsPin,
      'createdAt': (createdAt ?? datecreateChat)?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
      'deleted': deleted,
      'pendingImagePath': pendingImagePath,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'lastMessage': lastMessage,
      'image': image,
      'color_backgroung_icon': color_backgroung_icon,
      'nummessage': nummessage,
      'date': date != null ? Timestamp.fromDate(date!) : null,
      'time': time,
      'category': category,
      'datecreateChat': (datecreateChat ?? createdAt) != null
          ? Timestamp.fromDate(datecreateChat ?? createdAt!)
          : FieldValue.serverTimestamp(),
      'wallpaper': wallpaper,
      'boolNotification': boolNotification,
      'boolIsPin': boolIsPin,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'deleted': deleted,
    };
  }

  Map<String, dynamic> toFirestoreJson({bool isCreate = false}) {
    final isOnlineUrl =
        image != null && (image!.startsWith('http://') || image!.startsWith('https://'));

    return {
      'id': id,
      'name': name,
      'description': description,
      'lastMessage': lastMessage,
      'image': isOnlineUrl ? image : null,
      'color_backgroung_icon': color_backgroung_icon,
      'nummessage': nummessage,
      'date': date != null ? Timestamp.fromDate(date!) : null,
      'time': time,
      'category': category,
      'datecreateChat': (datecreateChat ?? createdAt) != null
          ? Timestamp.fromDate(datecreateChat ?? createdAt!)
          : FieldValue.serverTimestamp(),
      'wallpaper': wallpaper,
      'boolNotification': boolNotification,
      'boolIsPin': boolIsPin,
      'createdAt': isCreate
          ? FieldValue.serverTimestamp()
          : (createdAt != null
              ? Timestamp.fromDate(createdAt!)
              : FieldValue.serverTimestamp()),
      'updatedAt': FieldValue.serverTimestamp(),
      'deleted': deleted,
    };
  }

  ChatModel copyWith({
    String? id,
    String? name,
    String? description,
    String? lastMessage,
    String? image,
    int? color_backgroung_icon,
    int? nummessage,
    DateTime? date,
    String? time,
    String? category,
    DateTime? datecreateChat,
    String? wallpaper,
    bool? boolNotification,
    bool? boolIsPin,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? deleted,
    String? pendingImagePath,
    bool clearPendingImage = false,
  }) {
    return ChatModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      lastMessage: lastMessage ?? this.lastMessage,
      image: image ?? this.image,
      color_backgroung_icon:
          color_backgroung_icon ?? this.color_backgroung_icon,
      nummessage: nummessage ?? this.nummessage,
      date: date ?? this.date,
      time: time ?? this.time,
      category: category ?? this.category,
      datecreateChat: datecreateChat ?? this.datecreateChat,
      wallpaper: wallpaper ?? this.wallpaper,
      boolNotification: boolNotification ?? this.boolNotification,
      boolIsPin: boolIsPin ?? this.boolIsPin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deleted: deleted ?? this.deleted,
      pendingImagePath: clearPendingImage
          ? null
          : (pendingImagePath ?? this.pendingImagePath),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          lastMessage == other.lastMessage &&
          image == other.image &&
          color_backgroung_icon == other.color_backgroung_icon &&
          nummessage == other.nummessage &&
          date == other.date &&
          time == other.time &&
          category == other.category &&
          datecreateChat == other.datecreateChat &&
          wallpaper == other.wallpaper &&
          boolNotification == other.boolNotification &&
          boolIsPin == other.boolIsPin &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          deleted == other.deleted &&
          pendingImagePath == other.pendingImagePath;

  @override
  int get hashCode => Object.hash(
        id,
        name,
        description,
        lastMessage,
        image,
        color_backgroung_icon,
        nummessage,
        date,
        time,
        category,
        datecreateChat,
        wallpaper,
        boolNotification,
        boolIsPin,
        createdAt,
        updatedAt,
        deleted,
        pendingImagePath,
      );
}
