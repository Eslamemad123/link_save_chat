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
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class LoginSuccess extends AuthState {
  final UserEntity user;
  const LoginSuccess(this.user);
}

class SignUpSuccess extends AuthState {
  final UserEntity user;
  const SignUpSuccess(this.user);
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
}

