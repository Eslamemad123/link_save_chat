import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:link_savw_chat/features/chat/Presentation/page/chat_view.dart';
import 'package:link_savw_chat/features/chat/Presentation/widget/chat_input_bar.dart';
import 'package:link_savw_chat/features/chat/Presentation/widget/chat_send_button.dart';
import 'package:link_savw_chat/features/chat/Presentation/widget/chat_text_form_field.dart';
import 'package:link_savw_chat/features/home/Data/models/chat_model.dart';

void main() {
  const testChat = ChatModel(
    id: 'chat_123',
    name: 'Programming Links',
    description: 'A place for coding articles',
    color_backgroung_icon: 0,
    nummessage: 0,
    category: 'tech',
  );

  Widget createTestWidget(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) => MaterialApp(
        home: child,
      ),
    );
  }

  group('ChatView & Empty State Tests', () {
    testWidgets('renders ChatView with chat name and empty state UI',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(const ChatView(chat: testChat)),
      );
      await tester.pump();

      expect(find.text('Programming Links'), findsOneWidget);
      expect(find.text('A place for coding articles'), findsOneWidget);
      expect(find.text('No links yet'), findsOneWidget);
      expect(find.byType(ChatInputBar), findsOneWidget);
      expect(find.byType(ChatTextFormField), findsOneWidget);
      expect(find.byType(ChatSendButton), findsOneWidget);
    });

    testWidgets('entering text in ChatInputBar and pressing send triggers send',
        (tester) async {
      String? sentMessage;

      await tester.pumpWidget(
        createTestWidget(
          Scaffold(
            body: ChatInputBar(
              onSendMessage: (msg) {
                sentMessage = msg;
              },
            ),
          ),
        ),
      );
      await tester.pump();

      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      await tester.enterText(textField, 'https://flutter.dev');
      await tester.pump();

      final sendButton = find.byType(ChatSendButton);
      await tester.tap(sendButton);
      await tester.pump();

      expect(sentMessage, 'https://flutter.dev');
    });
  });
}
