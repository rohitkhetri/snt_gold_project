abstract class AuthState{}

class AuthInitial extends AuthState{}

class AuthLoading extends AuthState{}

class Authenticated extends AuthState{
  final String token;

  Authenticated(this.token);
}

class AuthError extends AuthState{
  final String error;

  AuthError(this.error);
}

class AuthLoggedout extends AuthState{}

class AuthRegistered extends AuthState {}  // <-- Add this state for successful registration
