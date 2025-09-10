import 'package:remote_mouse/enums/web_socket_connection_status.dart';
import 'package:remote_mouse/models/keybaord_model.dart';
import 'package:remote_mouse/models/mouse_data_model.dart';

abstract class KeyboardMouseRepo{
  void sendMouseEvent(MouseDataModel mouseDataModel);
  Future<WebSocketConnectionStatus> webSocketConnection(String address,int port);

  void sendKeyboardEvent(KeyboardModel keyboard);

}