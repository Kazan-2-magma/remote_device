import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remote_mouse/domain/usecases/udp_socket_usecase.dart';
import 'package:remote_mouse/models/remote_device.dart';
import 'package:remote_mouse/presentation/bloc/udp_socket/udp_socket_event.dart';
import 'package:remote_mouse/presentation/bloc/udp_socket/udp_socket_state.dart';

class UDPSocketBloc extends Bloc<UDPSocketEvent,UDPSocketState>{
  UDPSocketBloc({
    required UDPSocketUseCase udpSocketUseCase
}) :
        _udpSocketUseCase = udpSocketUseCase,
        super(UDPSocketInitialState()) {
    on<UDPSocketListenEvent>(_socketListen);
  }

  final UDPSocketUseCase _udpSocketUseCase;
  List<RemoteDevice> _devices = [];


  Future<void> _socketListen(UDPSocketListenEvent event,Emitter<UDPSocketState> emit) async  {
    try{
        emit(UDPSocketLoading());

        final sub = _udpSocketUseCase.call().listen((device) {
              if(!_devices.any((dev) => dev.name == device.name)){
                _devices.add(device);
                emit(UDPSocketLoaded(List.from(_devices)));
              }
          }
        );

        await Future.delayed(const Duration(seconds: 2));
        if(_devices.isEmpty){
          emit(UDPSocketLoaded([]));
        }
        await sub.cancel();


        // await emit.forEach<RemoteDevice>(
        //     _udpSocketUseCase.call().timeout(Duration(seconds: 1),onTimeout: (sink){
        //       print("skdjjks");
        //       sink.close();
        //       emit(UDPSocketError("No Devices Found"));
        //     }),
        //     onData: (device){
        //
        //       _devices.add(device);
        //
        //       print(device.name);
        //
        //       final devicesList = _devices.toList();
        //
        //       return UDPSocketLoaded(devicesList);
        //     },
        //   onError: (e,_){
        //       print("Error ${e.toString()}");
        //     return UDPSocketError(e.toString());
        //   },
        //
        // );



    }on Exception catch(e){
      debugPrint("${runtimeType.toString()} Error : ${e.toString()}");
    }
  }


}