part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    // this.user,
    this.isSuperAdmin = false,
    this.loadingStateAuth,
   
  });

  final bool? isSuperAdmin;
  // final Student? user;
  final LoadingStateAuth? loadingStateAuth;

  AuthState copyWith({
    bool? isSuperAdmin,
    // Student? user,
    LoadingStateAuth? loadingStateAuth,
  }) {
    return AuthState(
      // user: user ?? this.user,
      isSuperAdmin: this.isSuperAdmin,
      loadingStateAuth: loadingStateAuth ?? this.loadingStateAuth,
      );
  }

  @override
  List<Object?> get props => [
        // user,
        isSuperAdmin,
        loadingStateAuth,
        
      ];
}

enum LoadingStateAuth { loading, done, error }

class ErrorState extends AuthState {
  @override
  List<Object> get props => [];
}
