import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.photoUrl,
    super.phoneNumber,
    super.accountStatus = 'active',
    super.createdAt,
    super.deletedAt,
  });

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      photoUrl: entity.photoUrl,
      phoneNumber: entity.phoneNumber,
      accountStatus: entity.accountStatus,
      createdAt: entity.createdAt,
      deletedAt: entity.deletedAt,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      if (value is Timestamp) return value.toDate();
      if (value is String) return DateTime.tryParse(value);
      return null;
    }

    return UserModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      photoUrl: json['photoUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      accountStatus: json['accountStatus'] as String? ?? 'active',
      createdAt: parseDate(json['createdAt']),
      deletedAt: parseDate(json['deletedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
      'accountStatus': accountStatus,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
      'deletedAt': deletedAt != null ? Timestamp.fromDate(deletedAt!) : null,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? phoneNumber,
    String? accountStatus,
    DateTime? createdAt,
    DateTime? deletedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      accountStatus: accountStatus ?? this.accountStatus,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
