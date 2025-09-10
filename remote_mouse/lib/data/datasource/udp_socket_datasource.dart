import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:remote_mouse/models/remote_device.dart';

abstract class UDPSocketDatasource {
  const UDPSocketDatasource();
  Stream<RemoteDevice> socketListen();
}

class UDPSocketDatasourceImpl extends UDPSocketDatasource {

  Stream<RemoteDevice> socketListen() async* {
    try {


      RawDatagramSocket socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 9999);

      final seenDevice = <String>[];

      await for(final event in socket){
        if(event == RawSocketEvent.read){

          final datagram = socket.receive();
          
          if(datagram != null){

            final jsonMessage = jsonDecode(String.fromCharCodes(datagram.data));

            final device = RemoteDevice.fromJson(jsonMessage);

            final deviceKey = device.name;

            if(!seenDevice.contains(deviceKey)){
              seenDevice.add(deviceKey);
              yield device;
            }
          }
        }
      }


    }on Exception catch(e) {
      debugPrint("DataSource Error ${e.toString()}");

    }
  }
}