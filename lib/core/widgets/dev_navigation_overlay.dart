import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:coolicons/coolicons.dart';
import 'package:kikocode/features/auth/providers/auth_providers.dart';

/// Development-only navigation overlay with forward/backward buttons
/// Only visible in debug mode
class DevNavigationOverlay extends ConsumerWidget {
  final Widget child;

  const DevNavigationOverlay({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        child,
        Positioned(
          bottom: 20,
          right: 20,
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(30),
            color: Colors.black87,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Backward button
                  IconButton(
                    icon: const Icon(Coolicons.chevron_left, color: Colors.white, size: 20),
                    tooltip: '', // Disable tooltip to avoid Overlay requirement
                    onPressed: () {
                      try {
                        if (context.canPop()) {
                          context.pop();
                        }
                      } catch (e) {
                        // Silently fail if context doesn't have router
                        debugPrint('Cannot pop: $e');
                      }
                    },
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    color: Colors.white24,
                  ),
                  // Forward button (shows available routes)
                  PopupMenuButton<String>(
                    icon: const Icon(Coolicons.chevron_right, color: Colors.white, size: 20),
                    tooltip: '', // Disable tooltip to avoid Overlay requirement
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: '/',
                        child: Row(
                          children: [
                            Icon(Coolicons.home_outline, size: 18),
                            SizedBox(width: 8),
                            Text('Welcome'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: '/login',
                        child: Row(
                          children: [
                            Icon(Coolicons.user_circle, size: 18),
                            SizedBox(width: 8),
                            Text('Login'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: '/verification',
                        child: Row(
                          children: [
                            Icon(Coolicons.circle_check, size: 18),
                            SizedBox(width: 8),
                            Text('Verification'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: '/loading',
                        child: Row(
                          children: [
                            Icon(Coolicons.loading, size: 18),
                            SizedBox(width: 8),
                            Text('Loading'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: '/home',
                        child: Row(
                          children: [
                            Icon(Coolicons.grid, size: 18),
                            SizedBox(width: 8),
                            Text('Main Screen'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: '/group-selection',
                        child: Row(
                          children: [
                            Icon(Coolicons.user_plus, size: 18),
                            SizedBox(width: 8),
                            Text('Group Selection'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: '/messages',
                        child: Row(
                          children: [
                            Icon(Coolicons.message_circle, size: 18),
                            SizedBox(width: 8),
                            Text('Messages'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: '/message-status',
                        child: Row(
                          children: [
                            Icon(Coolicons.check_all, size: 18),
                            SizedBox(width: 8),
                            Text('Message Status'),
                          ],
                        ),
                      ),
                      const PopupMenuDivider(),
                      const PopupMenuItem(
                        value: '_logout',
                        child: Row(
                          children: [
                            Icon(Coolicons.log_out, size: 18, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Logout', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (value) async {
                      try {
                        if (value == '_logout') {
                          await ref.read(authStateProvider.notifier).signOut();
                          if (context.mounted) {
                            context.go('/login');
                          }
                        } else {
                          context.go(value);
                        }
                      } catch (e) {
                        debugPrint('Cannot navigate: $e');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

