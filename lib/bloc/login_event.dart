abstract class AuthEvent{}

class LoginEvent extends AuthEvent{
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class RegisterEvent extends AuthEvent{
  final Map<String, dynamic> userData;

  RegisterEvent(this.userData);
}

class LogoutEvent extends AuthEvent {
  final String token;
  LogoutEvent(this.token);
}