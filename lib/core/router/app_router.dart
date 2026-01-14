import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kikocode/features/auth/presentation/screens/welcome_screen.dart';
import 'package:kikocode/features/auth/presentation/screens/login_screen.dart';
import 'package:kikocode/features/auth/presentation/screens/verification_screen.dart';
import 'package:kikocode/features/auth/presentation/screens/loading_screen.dart';
import 'package:kikocode/features/home/presentation/screens/main_screen.dart';
import 'package:kikocode/features/messages/presentation/screens/group_selection_screen.dart';
import 'package:kikocode/features/messages/presentation/screens/message_page_screen.dart';
import 'package:kikocode/features/messages/presentation/screens/message_screen.dart';
import 'package:kikocode/features/messages/presentation/screens/message_status_screen.dart';
import 'package:kikocode/core/widgets/dev_navigation_overlay.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        // Add dev navigation overlay in debug mode
        if (kDebugMode) {
          return DevNavigationOverlay(child: child);
        }
        return child;
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'welcome',
          builder: (context, state) => const WelcomeScreen(),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/verification',
          name: 'verification',
          builder: (context, state) => const VerificationScreen(),
        ),
        GoRoute(
          path: '/loading',
          name: 'loading',
          builder: (context, state) => const LoadingScreen(),
        ),
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const MainScreen(),
        ),
        GoRoute(
          path: '/group-selection',
          name: 'group-selection',
          builder: (context, state) => const GroupSelectionScreen(),
        ),
        GoRoute(
          path: '/message-compose',
          name: 'message-compose',
          builder: (context, state) => const MessagePageScreen(),
        ),
        GoRoute(
          path: '/message-overview',
          name: 'message-overview',
          builder: (context, state) => const MessageStatusScreen(),
        ),
        GoRoute(
          path: '/messages',
          name: 'messages',
          builder: (context, state) => const MessageStatusScreen(),
        ),
        GoRoute(
          path: '/message/:groupName',
          name: 'message',
          builder: (context, state) {
            final groupName = state.pathParameters['groupName'] ?? 'Group';
            final extra = state.extra as Map<String, dynamic>?;
            return MessageScreen(
              groupName: groupName,
              groupIcon: extra?['groupIcon'] ?? '💬',
              initialMessages: extra?['messages'] as List<Map<String, dynamic>>?,
              isGroupChat: extra?['isGroupChat'] ?? true,
              childName: extra?['childName'] as String?,
              parentNames: extra?['parentNames'] as String?,
            );
          },
        ),
        GoRoute(
          path: '/message-status',
          name: 'message-status',
          builder: (context, state) => const MessageStatusScreen(),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.uri}'),
    ),
  ),
);

