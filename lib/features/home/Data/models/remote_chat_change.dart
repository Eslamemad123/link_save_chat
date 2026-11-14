class RemoteChatChange {
  final String chatId;
  final Map<String, dynamic> hiveData;
  final int? updatedAtMs;
  final bool hasPendingWrites;
  final bool isDeleted;

  const RemoteChatChange({
    required this.chatId,
    required this.hiveData,
    this.updatedAtMs,
    required this.hasPendingWrites,
    required this.isDeleted,
  });
}

