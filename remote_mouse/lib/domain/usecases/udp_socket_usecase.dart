import 'package:remote_mouse/core/usecases/usecases.dart';
import 'package:remote_mouse/domain/repositories/udp_socket_repo.dart';
import 'package:remote_mouse/models/remote_device.dart';

class UDPSocketUseCase extends UseCaseWithoutParamsStream{
  const UDPSocketUseCase(this._udpSocketRepo);
  final UDPSocketRepo _udpSocketRepo;

  @override
  Stream<RemoteDevice> call()  {
     return _udpSocketRepo.socketListen();
  }

}