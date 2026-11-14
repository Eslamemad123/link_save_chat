import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:link_savw_chat/features/home/Data/models/chat_model.dart';
import 'package:link_savw_chat/features/home/Presentation/cubit/home_cubit.dart';
import 'package:link_savw_chat/features/home/Presentation/widget/chat_card_item.dart';
import 'package:link_savw_chat/features/home/Presentation/widget/chat_empty.dart';
import 'package:link_savw_chat/features/home/Presentation/widget/chat_icon_avatar.dart';
import 'package:link_savw_chat/features/home/Presentation/widget/chat_list_view.dart';
import 'package:link_savw_chat/features/home/Presentation/widget/chat_unread_badge.dart';
import 'package:link_savw_chat/features/home/Presentation/widget/home_filter_chip_item.dart';
import 'package:link_savw_chat/features/home/Presentation/widget/home_header.dart';
import 'package:link_savw_chat/features/home/Presentation/widget/home_header_search_bar.dart';

import 'home_cubit_test.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) => MaterialApp(home: Scaffold(body: child)),
    );
  }

  group('Home Widgets Tests', () {
    testWidgets('ChatEmpty renders properly with text and icon', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestableWidget(const ChatEmpty(isDark: false)),
      );
      await tester.pump();

      expect(find.text('No Links or Tasks Found'), findsOneWidget);
      expect(
        find.text('Tap the + button to create a new category'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.folder_open_rounded), findsOneWidget);
    });

    testWidgets('ChatListView shows ChatEmpty when list is empty', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestableWidget(
          ChatListView(chats: const [], onRefresh: () async {}),
        ),
      );
      await tester.pump();

      expect(find.byType(ChatEmpty), findsOneWidget);
    });

    testWidgets(
      'ChatListView pull-to-refresh triggers onRefresh in empty state',
      (tester) async {
        bool refreshed = false;
        await tester.pumpWidget(
          buildTestableWidget(
            ChatListView(
              chats: const [],
              onRefresh: () async {
                refreshed = true;
              },
            ),
          ),
        );
        await tester.pump();

        await tester.drag(
          find.text('No Links or Tasks Found'),
          const Offset(0, 300),
        );
        await tester.pumpAndSettle();

        expect(refreshed, isTrue);
      },
    );

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

    test('ChatCardItem.formatTimestamp formats calendar dates correctly', () {
      final now = DateTime.now();

      final todayTime = ChatCardItem.formatTimestamp(now);
      expect(todayTime, matches(RegExp(r'^\d{2}:\d{2} (AM|PM)$')));

      final yesterday = DateTime(now.year, now.month, now.day - 1, 15, 0);
      expect(ChatCardItem.formatTimestamp(yesterday), 'Yesterday');

      final threeDaysAgo = DateTime(now.year, now.month, now.day - 3, 10, 0);
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      expect(
        ChatCardItem.formatTimestamp(threeDaysAgo),
        days[threeDaysAgo.weekday - 1],
      );

      final lastYear = DateTime(now.year - 1, 3, 15);
      expect(ChatCardItem.formatTimestamp(lastYear), 'Mar 15, ${now.year - 1}');

      final futureDate = now.add(const Duration(minutes: 30));
      expect(
        ChatCardItem.formatTimestamp(futureDate),
        matches(RegExp(r'^\d{2}:\d{2} (AM|PM)$')),
      );

      expect(ChatCardItem.formatTimestamp(null), '');
    });

    testWidgets('ChatUnreadBadge renders count correctly', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(const ChatUnreadBadge(count: 99)),
      );
      await tester.pump();

      expect(find.text('99'), findsOneWidget);
    });

    testWidgets(
      'ChatUnreadBadge renders counts greater than 99 without clipping',
      (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(const ChatUnreadBadge(count: 150)),
        );
        await tester.pump();

        expect(find.text('150'), findsOneWidget);
      },
    );

    testWidgets('ChatIconAvatar generates initials when image is null', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestableWidget(const ChatIconAvatar(name: 'LinkSync Team')),
      );
      await tester.pump();

      expect(find.text('LI'), findsOneWidget);
    });

    testWidgets('ChatIconAvatar handles network image URL without errors', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const ChatIconAvatar(
            image: 'https://images.unsplash.com/photo-1',
            name: 'Web User',
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('ChatIconAvatar falls back to initials when local file does not exist', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const ChatIconAvatar(
            image: '/non/existent/path/avatar.png',
            name: 'Offline Chat',
          ),
        ),
      );
      await tester.pump();

      expect(find.text('OF'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('HomeFilterChipItem renders label and triggers onTap', (
      tester,
    ) async {
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

    testWidgets('HomeHeaderSearchBar disposes controller cleanly', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BlocProvider(
            create: (_) => HomeCubit(dataSource: MockHomeDataSource()),
            child: const HomeHeaderSearchBar(),
          ),
        ),
      );
      await tester.pump();

      await tester.pumpWidget(buildTestableWidget(const SizedBox.shrink()));
      await tester.pump();

      expect(tester.takeException(), isNull);
    });

    for (final width in [320.0, 360.0, 390.0]) {
      testWidgets('HomeHeader renders without overflow on $width px width', (
        tester,
      ) async {
        await tester.pumpWidget(
          ScreenUtilInit(
            designSize: const Size(375, 812),
            builder: (context, _) => MaterialApp(
              home: Scaffold(
                body: SizedBox(
                  width: width,
                  child: BlocProvider(
                    create: (_) => HomeCubit(dataSource: MockHomeDataSource()),
                    child: const HomeHeader(),
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pump();

        expect(tester.takeException(), isNull);
        expect(find.byType(HomeHeader), findsOneWidget);
      });
    }
  });
}
