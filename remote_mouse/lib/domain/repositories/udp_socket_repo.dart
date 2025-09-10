import 'package:remote_mouse/models/remote_device.dart';

abstract class UDPSocketRepo {
  Stream<RemoteDevice> socketListen();
}