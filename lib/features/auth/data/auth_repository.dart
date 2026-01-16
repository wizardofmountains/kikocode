import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kikocode/core/config/supabase_config.dart';

class AuthRepository {
  /// Lazy access to Supabase client to avoid initialization issues
  SupabaseClient get _client => SupabaseConfig.client;

  /// Sign in with email and password
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// Sign up with email, password, and optional profile metadata
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    String? username,
    String? displayName,
  }) async {
    // Include username and display_name in user metadata
    // These will be used by the database trigger to create the profile
    final metadata = <String, dynamic>{};
    if (username != null) metadata['username'] = username;
    if (displayName != null) metadata['display_name'] = displayName;
    
    return await _client.auth.signUp(
      email: email,
      password: password,
      data: metadata.isNotEmpty ? metadata : null,
    );
  }

  /// Sign out the current user
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  /// Get the currently authenticated user
  User? get currentUser => _client.auth.currentUser;

  /// Stream of authentication state changes
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;
  
  /// Check if there is an active session
  bool get hasActiveSession => _client.auth.currentSession != null;
  
  /// Get the current session
  Session? get currentSession => _client.auth.currentSession;
}
