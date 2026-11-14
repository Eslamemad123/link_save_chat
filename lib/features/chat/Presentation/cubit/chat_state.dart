import '../../../home/Data/models/chat_model.dart';

class ChatState {
  final ChatModel chat;
  final bool isDeleted;
  final String? errorMessage;

  const ChatState({
    required this.chat,
    this.isDeleted = false,
    this.errorMessage,
  });

  bool get isPinned => chat.boolIsPin;
  bool get isMuted => !chat.boolNotification;

  ChatState copyWith({
    ChatModel? chat,
    bool? isDeleted,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ChatState(
      chat: chat ?? this.chat,
      isDeleted: isDeleted ?? this.isDeleted,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatState &&
          runtimeType == other.runtimeType &&
          chat == other.chat &&
          isDeleted == other.isDeleted &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => Object.hash(chat, isDeleted, errorMessage);
}

