import 'package:get_it/get_it.dart';
import 'package:remote_mouse/data/datasource/keyboard_mouse_datasource.dart';
import 'package:remote_mouse/data/repositories/keyboard_mouse_repo_impl.dart';
import 'package:remote_mouse/domain/repositories/keyboard_mouse_repo.dart';
import 'package:remote_mouse/domain/usecases/keyboard_usecase.dart';
import 'package:remote_mouse/domain/usecases/mouse_usecase.dart';
import 'package:remote_mouse/domain/usecases/web_socket_connection_usecase.dart';
import 'package:remote_mouse/presentation/bloc/keyboard_mouse/keyboard_mouse_bloc.dart';

final sl = GetIt.instance;


Future<void> init() async {


  sl..registerFactory(
      () => KeyboardMouseBloc(mouseUseCase: sl(), webSocketConnectionUseCase: sl(),keyboardUseCase: sl())
  )
      ..registerLazySingleton(() => MouseUseCase(sl()))
      ..registerLazySingleton(() => KeyboardUseCase(sl()))
      ..registerLazySingleton(() => WebSocketConnectionUseCase(sl()))
      ..registerLazySingleton<KeyboardMouseRepo>(() => KeyboardMouseRepoImpl(sl()))
      ..registerLazySingleton<KeyboardMouseDataSource>(() => KeyboardMouseDataSourceImpl());
}