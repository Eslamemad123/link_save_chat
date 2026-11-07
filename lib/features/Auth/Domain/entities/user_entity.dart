class UserEntity {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final String? phoneNumber;
  final String accountStatus;
  final DateTime? createdAt;
  final DateTime? deletedAt;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.phoneNumber,
    this.accountStatus = 'active',
    this.createdAt,
    this.deletedAt,
  });

  bool get isDeleted => accountStatus == 'deleted';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          photoUrl == other.photoUrl &&
          phoneNumber == other.phoneNumber &&
          accountStatus == other.accountStatus &&
          createdAt == other.createdAt &&
          deletedAt == other.deletedAt;

  @override
  int get hashCode => Object.hash(
        id,
        name,
        email,
        photoUrl,
        phoneNumber,
        accountStatus,
        createdAt,
        deletedAt,
      );
}
