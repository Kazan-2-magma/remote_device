import 'package:remote_mouse/models/remote_device.dart';

abstract class UDPSocketState {
  const UDPSocketState();
}

class UDPSocketInitialState extends UDPSocketState {
  const UDPSocketInitialState();
}
class UDPSocketLoading extends UDPSocketState {}
class UDPSocketLoaded extends UDPSocketState {

  final List<RemoteDevice> devices;
  UDPSocketLoaded(this.devices);
}
class UDPSocketError extends UDPSocketState {
  final String message;
  UDPSocketError(this.message);
}