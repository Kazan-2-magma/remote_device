import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remote_mouse/domain/usecases/keyboard_usecase.dart';
import 'package:remote_mouse/domain/usecases/mouse_usecase.dart';
import 'package:remote_mouse/domain/usecases/web_socket_connection_usecase.dart';
import 'package:remote_mouse/enums/web_socket_connection_status.dart';
import 'package:remote_mouse/presentation/bloc/keyboard_mouse/keyboard_mouse_event.dart';
import 'package:remote_mouse/presentation/bloc/keyboard_mouse/keyboard_mouse_state.dart';

class KeyboardMouseBloc extends Bloc<KeyboardMouseEvent,KeyboardMouseState>{
  KeyboardMouseBloc({
    required MouseUseCase mouseUseCase,
    required KeyboardUseCase keyboardUseCase,
    required WebSocketConnectionUseCase webSocketConnectionUseCase,
}) :    _mouseUseCase = mouseUseCase,
        _keyboardUseCase = keyboardUseCase,
        _webSocketConnectionUseCase = webSocketConnectionUseCase,
        super(KeyboardMouseInitialState()){
    on<MouseDataSentEvent>(_mouseDataSentEvent);
    on<WebSocketConnectionEvent>(_webSocketConnection);
    on<KeyboardDataSentEvent>(_keyboardDataSentEvent);
  }

  final MouseUseCase _mouseUseCase;
  final KeyboardUseCase _keyboardUseCase;
  final WebSocketConnectionUseCase _webSocketConnectionUseCase;

  void _keyboardDataSentEvent(KeyboardDataSentEvent event,Emitter<KeyboardMouseState> emit){
    try{
      print("Bloc");
      _keyboardUseCase.call(KeyboardParams(event.keyboardModel));
    }on Exception catch(e){
      debugPrint(e.toString());
    }
  }


  void _mouseDataSentEvent(MouseDataSentEvent event,Emitter<KeyboardMouseState> emit){
    try{
      _mouseUseCase.call(MouseParams(event.mouseDataModel));
    }on Exception catch(e){
      debugPrint(e.toString());
    }
  }

  void _webSocketConnection(WebSocketConnectionEvent event,Emitter<KeyboardMouseState> emit) async {
    try {
      emit(WebSocketConnectingState());

      final status = await _webSocketConnectionUseCase.call(WebSocketConnectionParams(event.remoteDevice));

      if(status.status == WebSocketConnectionStatus.connected.status){
        emit(WebSocketConnectionSuccessState());
      }else if(status.status == WebSocketConnectionStatus.failed.status){
        emit(WebSocketConnectionErrorState("Error: Network is unreachable"));
      }
      print(status.status);

    }on Exception catch(e){
      emit(WebSocketConnectionErrorState(e.toString()));
      debugPrint(e.toString());
    }
  }

}