import 'package:flutter/cupertino.dart';
import 'package:remote_mouse/data/datasource/udp_socket_datasource.dart';
import 'package:remote_mouse/domain/repositories/udp_socket_repo.dart';
import 'package:remote_mouse/models/remote_device.dart';

class UDPSocketRepoImpl extends UDPSocketRepo {

  UDPSocketRepoImpl(this._datasource);
  final UDPSocketDatasource _datasource;

  @override
  Stream<RemoteDevice> socketListen()  {
    return _datasource.socketListen();
  }




}