import 'package:kikocode/core/config/supabase_config.dart';
import 'package:kikocode/features/auth/data/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Repository for handling app startup initialization
/// 
/// Responsibilities:
/// - Initialize Supabase
/// - Check authentication status
/// - Return startup state
class StartupRepository {
  final AuthRepository _authRepository;

  StartupRepository(this._authRepository);

  /// Initialize the app and check authentication status
  /// 
  /// Returns the current authenticated user, or null if not authenticated
  /// Throws exception if initialization fails
  Future<User?> initializeApp() async {
    try {
      // Initialize Supabase if not already initialized
      await _initializeSupabase();
      
      // Check authentication status
      final user = _authRepository.currentUser;
      
      return user;
    } catch (e) {
      // Log error but don't throw - fail gracefully
      // In production, you might want to log to analytics
      // ignore: avoid_print
      print('Startup initialization error: $e');
      return null;
    }
  }

  /// Initialize Supabase configuration
  Future<void> _initializeSupabase() async {
    try {
      // Check if Supabase is already initialized
      if (Supabase.instance.client.auth.currentSession != null ||
          Supabase.instance.client.auth.currentUser != null) {
        // Already initialized
        return;
      }
    } catch (e) {
      // Not initialized yet, proceed with initialization
    }

    // Initialize Supabase
    await SupabaseConfig.initialize();
  }
}
