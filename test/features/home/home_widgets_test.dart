import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:link_savw_chat/features/home/Data/models/chat_model.dart';
import 'package:link_savw_chat/features/home/Presentation/widget/chat_empty.dart';
import 'package:link_savw_chat/features/home/Presentation/widget/chat_icon_avatar.dart';
import 'package:link_savw_chat/features/home/Presentation/widget/chat_list_view.dart';
import 'package:link_savw_chat/features/home/Presentation/widget/chat_unread_badge.dart';
import 'package:link_savw_chat/features/home/Presentation/widget/home_filter_chip_item.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) => MaterialApp(
        home: Scaffold(body: child),
      ),
    );
  }

  group('Home Widgets Tests', () {
    testWidgets('ChatEmpty renders properly with text and icon', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(const ChatEmpty(isDark: false)),
      );
      await tester.pump();

      expect(find.text('No Links or Tasks Found'), findsOneWidget);
      expect(find.text('Tap the + button to create a new category'), findsOneWidget);
      expect(find.byIcon(Icons.folder_open_rounded), findsOneWidget);
    });

    testWidgets('ChatListView shows ChatEmpty when list is empty', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          ChatListView(
            chats: const [],
            onRefresh: () async {},
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(ChatEmpty), findsOneWidget);
    });

    testWidgets('ChatListView renders items and triggers tap', (tester) async {
      ChatModel? tappedChat;
      final testChat = ChatModel(
        id: '1',
        name: 'Flutter Dev',
        description: 'Useful Flutter links',
        lastMessage: 'Check out this widget',
        color_backgroung_icon: 0xFF2196F3,
        nummessage: 2,
        category: 'tech',
        date: DateTime.now(),
        boolIsPin: true,
      );

      await tester.pumpWidget(
        buildTestableWidget(
          ChatListView(
            chats: [testChat],
            onRefresh: () async {},
            onChatTap: (chat) => tappedChat = chat,
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Flutter Dev'), findsOneWidget);
      expect(find.text('Check out this widget'), findsOneWidget);

      await tester.tap(find.text('Flutter Dev'));
      await tester.pump();

      expect(tappedChat, equals(testChat));
    });

    testWidgets('ChatUnreadBadge renders count correctly', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(const ChatUnreadBadge(count: 99)),
      );
      await tester.pump();

      expect(find.text('99'), findsOneWidget);
    });

    testWidgets('ChatIconAvatar generates initials when image is null', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(const ChatIconAvatar(name: 'LinkSync Team')),
      );
      await tester.pump();

      expect(find.text('LI'), findsOneWidget);
    });

    testWidgets('HomeFilterChipItem renders label and triggers onTap', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        buildTestableWidget(
          HomeFilterChipItem(
            label: 'All',
            isSelected: true,
            count: 5,
            onTap: () => tapped = true,
          ),
        ),
      );
      await tester.pump();

      expect(find.text('All'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);

      await tester.tap(find.text('All'));
      await tester.pump();

      expect(tapped, isTrue);
    });
  });
}

