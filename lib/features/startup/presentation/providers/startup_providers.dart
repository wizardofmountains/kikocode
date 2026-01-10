import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kikocode/features/auth/providers/auth_providers.dart';
import 'package:kikocode/features/startup/data/startup_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Provides the startup repository instance
final startupRepositoryProvider = Provider<StartupRepository>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return StartupRepository(authRepository);
});

/// App startup provider that initializes the app and checks authentication
/// 
/// This is a FutureProvider that:
/// - Initializes Supabase
/// - Checks authentication status
/// - Returns the current user (or null if not authenticated)
/// 
/// States:
/// - AsyncLoading: App is initializing
/// - AsyncData with User?: Initialization complete
///   - User != null: User is authenticated
///   - User == null: User is not authenticated
/// - AsyncError: Initialization failed
final appStartupProvider = FutureProvider<User?>((ref) async {
  final startupRepository = ref.watch(startupRepositoryProvider);
  return await startupRepository.initializeApp();
});
