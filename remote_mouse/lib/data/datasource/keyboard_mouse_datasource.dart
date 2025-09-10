import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:remote_mouse/enums/web_socket_connection_status.dart';
import 'package:remote_mouse/models/keybaord_model.dart';
import 'package:remote_mouse/models/mouse_data_model.dart';
import 'package:web_socket_channel/io.dart';

abstract class KeyboardMouseDataSource {
  const KeyboardMouseDataSource();

  void sendMouseEvent(MouseDataModel mouseDataModel);

  Future<WebSocketConnectionStatus> webSocketConnection(String address,int port);

  void sendKeyboardEvent(KeyboardModel keyboard);
}

class KeyboardMouseDataSourceImpl extends KeyboardMouseDataSource {

  IOWebSocketChannel? _ioWebSocketChannel;





  @override
  void sendMouseEvent(MouseDataModel mouseDataModel) {
    if(_ioWebSocketChannel == null) return;
    final event = jsonEncode({
      "action" : mouseDataModel.action,
      "dx" : mouseDataModel.dx,
      "dy" : mouseDataModel.dy,
    });
    _ioWebSocketChannel!.sink.add(event);
  }


  @override
  Future<WebSocketConnectionStatus> webSocketConnection(String address, int port) async {
    final completer = Completer<WebSocketConnectionStatus>();
    try {

      _ioWebSocketChannel = IOWebSocketChannel.connect(
          "ws://$address:$port"
      );

      completer.complete(WebSocketConnectionStatus.connected);

      return completer.future;

    }on SocketException catch(e,s){
      debugPrintStack(stackTrace: s);
      debugPrint(e.message);
      completer.complete(WebSocketConnectionStatus.failed);
      return completer.future;
    }on Exception catch(e){
      debugPrint(e.toString());
      return WebSocketConnectionStatus.failed;
    }finally {

    }
  }

  @override
  void sendKeyboardEvent(KeyboardModel keyboard) {
    try {
      print(keyboard.key);
      if(_ioWebSocketChannel == null) return;

      final event = jsonEncode({
        "action" : keyboard.action,
        "key" : keyboard.key,
        "modifiers" : keyboard.modifiers,
      });

      _ioWebSocketChannel!.sink.add(event);

    }on Exception catch(e){
      debugPrint(e.toString());
    }
  }

}