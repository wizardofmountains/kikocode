import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Development-only navigation overlay with forward/backward buttons
/// Only visible in debug mode
class DevNavigationOverlay extends StatelessWidget {
  final Widget child;

  const DevNavigationOverlay({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Backward button
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Cannot go back'),
                            duration: Duration(milliseconds: 500),
                          ),
                        );
                      }
                    },
                    tooltip: 'Go Back',
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    color: Colors.white24,
                  ),
                  // Forward button (shows available routes)
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    tooltip: 'Navigate Forward',
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: '/',
                        child: Row(
                          children: [
                            Icon(Icons.home, size: 18),
                            SizedBox(width: 8),
                            Text('Welcome'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: '/login',
                        child: Row(
                          children: [
                            Icon(Icons.login, size: 18),
                            SizedBox(width: 8),
                            Text('Login'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: '/verification',
                        child: Row(
                          children: [
                            Icon(Icons.verified_user, size: 18),
                            SizedBox(width: 8),
                            Text('Verification'),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (route) {
                      context.go(route);
                    },
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    color: Colors.white24,
                  ),
                  // Current route indicator
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      _getCurrentRouteName(context),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getCurrentRouteName(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    switch (location) {
      case '/':
        return 'Welcome';
      case '/login':
        return 'Login';
      case '/verification':
        return 'Verification';
      default:
        return location;
    }
  }
}

