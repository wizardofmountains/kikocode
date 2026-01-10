import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kikocode/core/router/app_router.dart';
import 'package:kikocode/core/design_system/design_system.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Note: Supabase initialization is now handled by the StartupScreen
  // via the startup system to ensure proper initialization flow

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'KIKO - Kommunikation kinderleicht!',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: appRouter,
    );
  }
}
