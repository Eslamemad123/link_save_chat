import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Data/models/user_model.dart';
import '../../Domain/entities/user_entity.dart';
import '../../Domain/usecases/delete_account_use_case.dart';
import '../../Domain/usecases/edit_profile_use_case.dart';
import '../../Domain/usecases/get_current_user_use_case.dart';
import '../../Domain/usecases/login_use_case.dart';
import '../../Domain/usecases/logout_use_case.dart';
import '../../Domain/usecases/reset_password_use_case.dart';
import '../../Domain/usecases/sign_in_with_facebook_use_case.dart';
import '../../Domain/usecases/sign_in_with_google_use_case.dart';
import '../../Domain/usecases/sign_up_use_case.dart';
import '../../Domain/usecases/update_password_use_case.dart';
import '../../Domain/usecases/watch_auth_state_use_case.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final WatchAuthStateUseCase watchAuthStateUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final LoginUseCase loginUseCase;
  final SignUpUseCase? signUpUseCase;
  final LogoutUseCase? logoutUseCase;
  final ResetPasswordUseCase? resetPasswordUseCase;
  final UpdatePasswordUseCase? updatePasswordUseCase;
  final DeleteAccountUseCase? deleteAccountUseCase;
  final EditProfileUseCase? editProfileUseCase;
  final SignInWithGoogleUseCase? signInWithGoogleUseCase;
  final SignInWithFacebookUseCase? signInWithFacebookUseCase;

  StreamSubscription<UserEntity?>? _authStateSubscription;

  AuthCubit({
    required this.watchAuthStateUseCase,
    required this.getCurrentUserUseCase,
    required this.loginUseCase,
    this.signUpUseCase,
    this.logoutUseCase,
    this.resetPasswordUseCase,
    this.updatePasswordUseCase,
    this.deleteAccountUseCase,
    this.editProfileUseCase,
    this.signInWithGoogleUseCase,
    this.signInWithFacebookUseCase,
  }) : super(const AuthChecking()) {
    _initSessionWatcher();
  }

  void _initSessionWatcher() {
    _authStateSubscription = watchAuthStateUseCase().listen(
      (user) {
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(const AuthUnauthenticated());
        }
      },
      onError: (error) {
        emit(AuthError(error.toString()));
      },
    );
  }

  UserEntity? get currentUser => getCurrentUserUseCase();

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    final result = await loginUseCase(email: email, password: password);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(LoginSuccess(user)),
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    if (signUpUseCase == null) return;
    emit(const AuthLoading());
    final result = await signUpUseCase!(
      email: email,
      password: password,
      name: name,
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(SignUpSuccess(user)),
    );
  }

  Future<void> logout() async {
    if (logoutUseCase == null) return;
    emit(const AuthLoading());
    final result = await logoutUseCase!();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const LogoutSuccess()),
    );
  }

  Future<void> resetPassword({required String email}) async {
    if (resetPasswordUseCase == null) return;
    emit(const AuthLoading());
    final result = await resetPasswordUseCase!(email: email);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const PasswordResetSent()),
    );
  }

  Future<void> updatePassword({required String newPassword}) async {
    if (updatePasswordUseCase == null) return;
    emit(const AuthLoading());
    final result = await updatePasswordUseCase!(newPassword: newPassword);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const PasswordUpdated()),
    );
  }

  Future<void> deleteAccount() async {
    if (deleteAccountUseCase == null) return;
    emit(const AuthLoading());
    final result = await deleteAccountUseCase!();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const AccountDeleted()),
    );
  }

  Future<void> editProfile({required UserModel user}) async {
    if (editProfileUseCase == null) return;
    emit(const AuthLoading());
    final result = await editProfileUseCase!(user: user);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const ProfileUpdated()),
    );
  }

  Future<void> signInWithGoogle() async {
    if (signInWithGoogleUseCase == null) return;
    emit(const AuthLoading());
    final result = await signInWithGoogleUseCase!();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(LoginSuccess(user)),
    );
  }

  Future<void> signInWithFacebook() async {
    if (signInWithFacebookUseCase == null) return;
    emit(const AuthLoading());
    final result = await signInWithFacebookUseCase!();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(LoginSuccess(user)),
    );
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}

