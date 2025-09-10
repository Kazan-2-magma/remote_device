import 'package:flutter/foundation.dart';
import 'package:remote_mouse/data/datasource/keyboard_mouse_datasource.dart';
import 'package:remote_mouse/domain/repositories/keyboard_mouse_repo.dart';
import 'package:remote_mouse/enums/web_socket_connection_status.dart';
import 'package:remote_mouse/models/keybaord_model.dart';
import 'package:remote_mouse/models/mouse_data_model.dart';

class KeyboardMouseRepoImpl extends KeyboardMouseRepo {
  KeyboardMouseRepoImpl(this.keyboardMouseDataSource);

  final KeyboardMouseDataSource keyboardMouseDataSource;

  @override
  void sendMouseEvent(MouseDataModel mouseDataModel) {
    try {
      keyboardMouseDataSource.sendMouseEvent(
        mouseDataModel
      );
    }on Exception catch(e){
      debugPrint(e.toString());
    }
  }

  @override
  Future<WebSocketConnectionStatus> webSocketConnection(String address, int port) async {
    try{
      final status = keyboardMouseDataSource.webSocketConnection(address, port);

      return status;
    }on Exception catch(e){
      debugPrint(e.toString());
      return WebSocketConnectionStatus.failed;
    }
  }

  @override
  void sendKeyboardEvent(KeyboardModel keyboard) {
    try{
      keyboardMouseDataSource.sendKeyboardEvent(keyboard);
    }on Exception catch(e){
      debugPrint(e.toString());
    }
  }




}