import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class RemoteControl extends StatefulWidget {
  const RemoteControl({super.key});

  @override
  State<RemoteControl> createState() => _RemoteControlState();
}

class _RemoteControlState extends State<RemoteControl> {

  late IOWebSocketChannel ioWebSocketChannel;


  @override
  void initState() {
    super.initState();

    listenForServer();

  }

  void listenForServer() async {

    RawDatagramSocket socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 9999);

    socket.listen((RawSocketEvent event){
      if(event == RawSocketEvent.read){
        Datagram? d = socket.receive();
        if(d != null){
          String msg = String.fromCharCodes(d.data);
          final jsonMsg = jsonDecode(msg);

          final port = jsonMsg["port"];
          final name = jsonMsg["name"];

          print(name);

          // ioWebSocketChannel = IOWebSocketChannel.connect(
          //     "ws://${d.address.address}:${port}"
          // );
        }
      }
    });


  }


  void sendEvent(String action,{double dx=0,double dy=0}){
      final event = jsonEncode({
        "action" : action,
        "dx":dx,
        "dy":dy
      });

      ioWebSocketChannel.sink.add(event);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GestureDetector(
            onPanUpdate: (details){
              sendEvent("move",dx: details.delta.dx,dy: details.delta.dy);
              print(details.delta);
            },
            onTap: (){
              sendEvent("click");
            },
          )
      ),
    );
  }
}
