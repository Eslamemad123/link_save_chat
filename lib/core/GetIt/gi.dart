import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../features/Auth/Data/datasources/auth_remote_data_source.dart';
import '../../features/Auth/Data/datasources/auth_remote_data_source_impl.dart';
import '../../features/Auth/Data/repositories/auth_repository_impl.dart';
import '../../features/Auth/Domain/repositories/auth_repository.dart';
import '../../features/Auth/Domain/usecases/delete_account_use_case.dart';
import '../../features/Auth/Domain/usecases/edit_profile_use_case.dart';
import '../../features/Auth/Domain/usecases/get_current_user_use_case.dart';
import '../../features/Auth/Domain/usecases/login_use_case.dart';
import '../../features/Auth/Domain/usecases/logout_use_case.dart';
import '../../features/Auth/Domain/usecases/reset_password_use_case.dart';
import '../../features/Auth/Domain/usecases/sign_in_with_facebook_use_case.dart';
import '../../features/Auth/Domain/usecases/sign_in_with_google_use_case.dart';
import '../../features/Auth/Domain/usecases/sign_up_use_case.dart';
import '../../features/Auth/Domain/usecases/update_password_use_case.dart';
import '../../features/Auth/Domain/usecases/watch_auth_state_use_case.dart';
import '../../features/Auth/Presentation/cubit/auth_cubit.dart';
import '../../features/home/Data/datasources/categories_local_data_source.dart';
import '../../features/home/Data/datasources/categories_local_data_source_impl.dart';
import '../../features/home/Data/datasources/chats_local_data_source.dart';
import '../../features/home/Data/datasources/chats_local_data_source_impl.dart';
import '../../features/home/Data/datasources/chats_remote_data_source.dart';
import '../../features/home/Data/datasources/chats_remote_data_source_impl.dart';
import '../../features/home/Data/datasources/home_data_source.dart';
import '../../features/home/Data/datasources/home_data_source_impl.dart';
import '../../features/home/Data/repositories/chats_repository_impl.dart';
import '../../features/home/Data/repositories/home_repository_impl.dart';
import '../../features/home/Domain/repositories/chats_repository.dart';
import '../../features/home/Domain/repositories/home_repository.dart';
import '../../features/home/Domain/usecases/add_chat_use_case.dart';
import '../../features/home/Domain/usecases/get_chats_use_case.dart';
import '../../features/home/Presentation/cubit/home_cubit.dart';
import '../services/sync/sync_service.dart';

final gi = GetIt.instance;

Future<void> setupServiceLocator() async {
  gi.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  gi.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  gi.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: gi<FirebaseAuth>(),
      firestore: gi<FirebaseFirestore>(),
    ),
  );

  gi.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: gi<AuthRemoteDataSource>()),
  );

  gi.registerLazySingleton<WatchAuthStateUseCase>(
    () => WatchAuthStateUseCase(repository: gi<AuthRepository>()),
  );

  gi.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(repository: gi<AuthRepository>()),
  );

  gi.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(repository: gi<AuthRepository>()),
  );

  gi.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(repository: gi<AuthRepository>()),
  );

  gi.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(repository: gi<AuthRepository>()),
  );

  gi.registerLazySingleton<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(repository: gi<AuthRepository>()),
  );

  gi.registerLazySingleton<UpdatePasswordUseCase>(
    () => UpdatePasswordUseCase(repository: gi<AuthRepository>()),
  );

  gi.registerLazySingleton<DeleteAccountUseCase>(
    () => DeleteAccountUseCase(repository: gi<AuthRepository>()),
  );

  gi.registerLazySingleton<EditProfileUseCase>(
    () => EditProfileUseCase(repository: gi<AuthRepository>()),
  );

  gi.registerLazySingleton<SignInWithGoogleUseCase>(
    () => SignInWithGoogleUseCase(repository: gi<AuthRepository>()),
  );

  gi.registerLazySingleton<SignInWithFacebookUseCase>(
    () => SignInWithFacebookUseCase(repository: gi<AuthRepository>()),
  );

  gi.registerFactory<AuthCubit>(
    () => AuthCubit(
      watchAuthStateUseCase: gi<WatchAuthStateUseCase>(),
      getCurrentUserUseCase: gi<GetCurrentUserUseCase>(),
      loginUseCase: gi<LoginUseCase>(),
      signUpUseCase: gi<SignUpUseCase>(),
      logoutUseCase: gi<LogoutUseCase>(),
      resetPasswordUseCase: gi<ResetPasswordUseCase>(),
      updatePasswordUseCase: gi<UpdatePasswordUseCase>(),
      deleteAccountUseCase: gi<DeleteAccountUseCase>(),
      editProfileUseCase: gi<EditProfileUseCase>(),
      signInWithGoogleUseCase: gi<SignInWithGoogleUseCase>(),
      signInWithFacebookUseCase: gi<SignInWithFacebookUseCase>(),
    ),
  );

  gi.registerLazySingleton<ChatsLocalDataSource>(
    () => ChatsLocalDataSourceImpl(chatsBox: Hive.box('chats')),
  );

  gi.registerLazySingleton<CategoriesLocalDataSource>(
    () => CategoriesLocalDataSourceImpl(categoriesBox: Hive.box('categories')),
  );

  gi.registerLazySingleton<ChatsRemoteDataSource>(
    () => ChatsRemoteDataSourceImpl(
      firestore: gi<FirebaseFirestore>(),
      firebaseAuth: gi<FirebaseAuth>(),
    ),
  );

  gi.registerLazySingleton<ChatsRepository>(
    () => ChatsRepositoryImpl(
      chatsLocalDataSource: gi<ChatsLocalDataSource>(),
      categoriesLocalDataSource: gi<CategoriesLocalDataSource>(),
      chatsRemoteDataSource: gi<ChatsRemoteDataSource>(),
    ),
  );

  gi.registerLazySingleton<SyncService>(
    () => SyncService(
      chatsLocalDataSource: gi<ChatsLocalDataSource>(),
      categoriesLocalDataSource: gi<CategoriesLocalDataSource>(),
      chatsRemoteDataSource: gi<ChatsRemoteDataSource>(),
      chatsRepository: gi<ChatsRepository>(),
      metaBox: Hive.box('meta'),
      firebaseAuth: gi<FirebaseAuth>(),
    ),
  );

  gi.registerLazySingleton<HomeDataSource>(
    () => HomeDataSourceImpl(
      firestore: gi<FirebaseFirestore>(),
      firebaseAuth: gi<FirebaseAuth>(),
    ),
  );
  gi.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(dataSource: gi<HomeDataSource>()),
  );
  gi.registerLazySingleton<GetChatsUseCase>(
    () => GetChatsUseCase(repository: gi<HomeRepository>()),
  );
  gi.registerLazySingleton<AddChatUseCase>(
    () => AddChatUseCase(repository: gi<HomeRepository>()),
  );

  gi.registerFactory<HomeCubit>(
    () => HomeCubit(repository: gi<ChatsRepository>()),
  );
}
