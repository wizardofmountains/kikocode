import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kikocode/features/auth/data/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Auth Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

// Current User Provider
final currentUserProvider = StreamProvider<User?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges.map((state) => state.session?.user);
});

// Auth State Provider
final authStateProvider = StateNotifierProvider<AuthStateNotifier, AsyncValue<User?>>((ref) {
  return AuthStateNotifier(ref.watch(authRepositoryProvider));
});

class AuthStateNotifier extends StateNotifier<AsyncValue<User?>> {
  final AuthRepository _authRepository;

  AuthStateNotifier(this._authRepository) : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    state = AsyncValue.data(_authRepository.currentUser);
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    try {
      final response = await _authRepository.signIn(
        email: email,
        password: password,
      );
      state = AsyncValue.data(response.user);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    try {
      final response = await _authRepository.signUp(
        email: email,
        password: password,
      );
      state = AsyncValue.data(response.user);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    try {
      await _authRepository.signOut();
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

