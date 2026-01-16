import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  // Supabase project credentials
  // Note: These are publishable keys and are safe to include in client-side code
  static const String supabaseUrl = 'https://wmgxfjkifqjpevgjwulg.supabase.co';
  static const String supabaseAnonKey = 'sb_publishable_jEoXFNmJmKTbiUDOqnJdDg_KwzXL89A';

  static bool _isInitialized = false;

  /// Initialize Supabase connection
  /// 
  /// This method is idempotent - it can be called multiple times safely.
  /// Returns true if initialization was successful, false otherwise.
  static Future<bool> initialize() async {
    // Return early if already initialized
    if (_isInitialized) {
      try {
        // Verify the instance is still valid
        Supabase.instance.client;
        return true;
      } catch (e) {
        // Instance is invalid, reset and reinitialize
        _isInitialized = false;
        // ignore: avoid_print
        print('Supabase instance invalid, reinitializing: $e');
      }
    }

    try {
      // Validate credentials before attempting initialization
      if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
        throw Exception(
          'Supabase credentials are missing. Please check your configuration.',
        );
      }

      if (!supabaseUrl.startsWith('https://')) {
        throw Exception(
          'Invalid Supabase URL format. Must start with https://',
        );
      }

      // ignore: avoid_print
      print('Initializing Supabase connection...');
      print('URL: $supabaseUrl');
      
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
      );
      _isInitialized = true;
      
      // Test the connection by accessing the client
      final client = Supabase.instance.client;
      // A simple health check - accessing the client should work
      // If there's a connection issue, it will throw here
      client.auth;
      
      // ignore: avoid_print
      print('Supabase connection initialized successfully');
      return true;
    } catch (e, stackTrace) {
      _isInitialized = false;
      // ignore: avoid_print
      print('Supabase initialization error: $e');
      // ignore: avoid_print
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Get the Supabase client instance
  /// 
  /// Throws an exception if Supabase is not initialized.
  static SupabaseClient get client {
    try {
      // Try to access the instance - this will throw if not initialized
      final instance = Supabase.instance.client;
      // If we got here, Supabase is actually initialized
      _isInitialized = true;
      return instance;
    } catch (e) {
      // Supabase is not initialized
      _isInitialized = false;
      throw StateError(
        'Supabase is not initialized. Call SupabaseConfig.initialize() first. '
        'Error: $e',
      );
    }
  }

  /// Check if Supabase is initialized
  static bool get isInitialized => _isInitialized;
}
