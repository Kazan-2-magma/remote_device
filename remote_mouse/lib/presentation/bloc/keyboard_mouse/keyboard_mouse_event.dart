import 'package:remote_mouse/models/keybaord_model.dart';
import 'package:remote_mouse/models/mouse_data_model.dart';
import 'package:remote_mouse/models/remote_device.dart';

abstract class KeyboardMouseEvent {
  const KeyboardMouseEvent();
}

class MouseDataSentEvent extends KeyboardMouseEvent{
  final MouseDataModel mouseDataModel;
  const MouseDataSentEvent(this.mouseDataModel);
}

class WebSocketConnectionEvent extends KeyboardMouseEvent {
  const WebSocketConnectionEvent(this.remoteDevice);
  final RemoteDevice remoteDevice;
}

class KeyboardDataSentEvent extends KeyboardMouseEvent {
  const KeyboardDataSentEvent(this.keyboardModel);
  final KeyboardModel keyboardModel;
}