import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kikocode/features/auth/screens/screens.dart';
import 'package:kikocode/features/home/presentation/screens/main_screen.dart';
import 'package:kikocode/features/messages/presentation/screens/group_selection_screen.dart';
import 'package:kikocode/features/messages/presentation/screens/message_page_screen.dart';
import 'package:kikocode/features/messages/presentation/screens/message_screen.dart';
import 'package:kikocode/features/messages/presentation/screens/message_status_screen.dart';
import 'package:kikocode/features/startup/presentation/screens/startup_screen.dart';
import 'package:kikocode/core/widgets/dev_navigation_overlay.dart';
import 'package:kikocode/core/components/component_showcase_screen.dart';
import 'package:kikocode/core/design_system/showcase_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/startup',
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
          path: '/startup',
          name: 'startup',
          builder: (context, state) => const StartupScreen(),
        ),
        GoRoute(
          path: '/',
          name: 'welcome',
          builder: (context, state) => const WelcomeScreen(),
        ),
        GoRoute(
          path: '/auth/login',
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/auth/verification',
          name: 'verification',
          builder: (context, state) {
            final username = state.extra as String? ?? 'User';
            return VerificationScreen(username: username);
          },
        ),
        GoRoute(
          path: '/auth/loading',
          name: 'loading',
          builder: (context, state) {
            final username = state.extra as String? ?? 'User';
            return LoadingScreen(username: username);
          },
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
          path: '/messages',
          name: 'messages',
          builder: (context, state) => const MessagePageScreen(),
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
            );
          },
        ),
        GoRoute(
          path: '/message-status',
          name: 'message-status',
          builder: (context, state) => const MessageStatusScreen(),
        ),
        // Developer/Design Routes
        GoRoute(
          path: '/showcase/components',
          name: 'component-showcase',
          builder: (context, state) => const ComponentShowcaseScreen(),
        ),
        GoRoute(
          path: '/showcase/design-system',
          name: 'design-system-showcase',
          builder: (context, state) => const DesignSystemShowcase(),
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

