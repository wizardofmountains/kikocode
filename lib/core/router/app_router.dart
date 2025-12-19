import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kikocode/features/auth/presentation/screens/welcome_screen.dart';
import 'package:kikocode/features/auth/presentation/screens/login_screen.dart';
import 'package:kikocode/features/auth/presentation/screens/verification_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
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
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.uri}'),
    ),
  ),
);

