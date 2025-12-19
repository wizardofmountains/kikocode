import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kikocode/core/router/app_router.dart';
import 'package:kikocode/core/widgets/dev_navigation_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase (you'll need to add your credentials)
  // await Supabase.initialize(
  //   url: 'YOUR_SUPABASE_URL',
  //   anonKey: 'YOUR_SUPABASE_ANON_KEY',
  // );

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB794F6), // Purple from design
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5EFE0), // Beige background
      ),
      routerConfig: appRouter,
      // Add development navigation overlay in debug mode
      builder: (context, child) {
        if (kDebugMode && child != null) {
          return DevNavigationOverlay(child: child);
        }
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
