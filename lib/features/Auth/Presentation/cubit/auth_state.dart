import '../../Domain/entities/user_entity.dart';

sealed class AuthState {
  const AuthState();
}

class AuthChecking extends AuthState {
  const AuthChecking();
}

class AuthAuthenticated extends AuthState {
  final UserEntity user;
  const AuthAuthenticated(this.user);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthAuthenticated &&
          runtimeType == other.runtimeType &&
          user == other.user;

  @override
  int get hashCode => user.hashCode;
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthLoading extends AuthState {
  final String? action;
  const AuthLoading({this.action});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthLoading &&
          runtimeType == other.runtimeType &&
          action == other.action;

  @override
  int get hashCode => action.hashCode;
}

class LoginSuccess extends AuthState {
  final UserEntity user;
  const LoginSuccess(this.user);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginSuccess &&
          runtimeType == other.runtimeType &&
          user == other.user;

  @override
  int get hashCode => user.hashCode;
}

class SignUpSuccess extends AuthState {
  final UserEntity user;
  const SignUpSuccess(this.user);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignUpSuccess &&
          runtimeType == other.runtimeType &&
          user == other.user;

  @override
  int get hashCode => user.hashCode;
}

class LogoutSuccess extends AuthState {
  const LogoutSuccess();
}

class PasswordResetSent extends AuthState {
  const PasswordResetSent();
}

class PasswordUpdated extends AuthState {
  const PasswordUpdated();
}

class ProfileUpdated extends AuthState {
  const ProfileUpdated();
}

class AccountDeleted extends AuthState {
  const AccountDeleted();
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthError &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
