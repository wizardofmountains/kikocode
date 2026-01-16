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
        // Authentication routes
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/verification',
          name: 'verification',
          builder: (context, state) {
            final username = state.extra as String? ?? 'User';
            return VerificationScreen(username: username);
          },
        ),
        GoRoute(
          path: '/loading',
          name: 'loading',
          builder: (context, state) {
            // Support both simple string (username) and map parameters
            final extra = state.extra;
            if (extra is String) {
              return LoadingScreen(username: extra);
            }
            final params = extra as Map<String, dynamic>?;
            return LoadingScreen(
              username: params?['username'] as String?,
              showFaceId: params?['showFaceId'] as bool? ?? false,
              showLoadingPhase: params?['showLoadingPhase'] as bool? ?? false,
            );
          },
        ),
        GoRoute(
          path: '/biometric',
          name: 'biometric-auth',
          builder: (context, state) => const BiometricAuthScreen(),
        ),
        GoRoute(
          path: '/auth-success',
          name: 'auth-success',
          builder: (context, state) {
            // Use unified LoadingScreen (AuthSuccessScreen functionality merged)
            final extra = state.extra as Map<String, dynamic>?;
            return LoadingScreen(
              username: extra?['username'] as String?,
              showFaceId: extra?['showFaceId'] as bool? ?? false,
            );
          },
        ),
        // Main app routes
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) {
            final username = state.extra as String? ?? 'User';
            return MainScreen(username: username);
          },
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
              childId: extra?['childId'] as String?,
              conversationId: extra?['conversationId'] as String?,
              eventId: extra?['eventId'] as String?,
              groupMessageId: extra?['groupMessageId'] as String?,
              parentNames: extra?['parentNames'] as String?,
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
