import 'package:flutter/cupertino.dart';
import 'package:remote_mouse/core/usecases/usecases.dart';
import 'package:remote_mouse/domain/repositories/keyboard_mouse_repo.dart';
import 'package:remote_mouse/enums/web_socket_connection_status.dart';
import 'package:remote_mouse/models/remote_device.dart';
import 'package:remote_mouse/presentation/bloc/keyboard_mouse/keyboard_mouse_bloc.dart';

class WebSocketConnectionUseCase extends UseCasesWithParams<WebSocketConnectionStatus,WebSocketConnectionParams>{
  const WebSocketConnectionUseCase(this._keyboardMouseRepo);

  final KeyboardMouseRepo _keyboardMouseRepo;

  @override
  Future<WebSocketConnectionStatus> call(WebSocketConnectionParams params) async {
    try {
      return await _keyboardMouseRepo.webSocketConnection(params.remoteDevice.address, params.remoteDevice.port);
    }on Exception catch(e){
      debugPrint(e.toString());
      return WebSocketConnectionStatus.failed;
    }
  }

}


class WebSocketConnectionParams  {
  final RemoteDevice remoteDevice;
  const WebSocketConnectionParams(this.remoteDevice);
}