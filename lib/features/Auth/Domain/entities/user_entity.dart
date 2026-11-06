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
}

