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
  });

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

    final img =
        json['image'] as String? ??
        json['image_or_icon'] as String? ??
        json['iconUrl'] as String?;
    final lastMsg =
        json['lastMessage'] as String? ?? json['description'] as String? ?? '';
    final chatName = json['name'] as String? ?? json['title'] as String? ?? '';
    final isPinned = parseBool(json['boolIsPin'] ?? json['isPinned'], false);
    final numMsg = parseInt(json['nummessage'] ?? json['uncompletedCount']);
    final createdDate = parseDate(
      json['datecreateChat'] ?? json['updatedAt'] ?? json['createdAt'],
    );

    return ChatModel(
      id: json['id'] as String? ?? '',
      name: chatName,
      description: json['description'] as String? ?? '',
      lastMessage: lastMsg,
      image: img,
      color_backgroung_icon: parseInt(json['color_backgroung_icon']),
      nummessage: numMsg,
      date: parseDate(json['date']),
      time: json['time'] as String?,
      category: json['category'] as String? ?? 'all',
      datecreateChat: createdDate,
      wallpaper: json['wallpaper'] as String?,
      boolNotification: parseBool(json['boolNotification'], true),
      boolIsPin: isPinned,
    );
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
      'datecreateChat': datecreateChat != null
          ? Timestamp.fromDate(datecreateChat!)
          : FieldValue.serverTimestamp(),
      'wallpaper': wallpaper,
      'boolNotification': boolNotification,
      'boolIsPin': boolIsPin,
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
          boolIsPin == other.boolIsPin;

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
  );
}
