import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remote_mouse/components/remote_udp_container.dart';
import 'package:remote_mouse/data/datasource/udp_socket_datasource.dart';
import 'package:remote_mouse/data/repositories/udp_socket_repo_impl.dart';
import 'package:remote_mouse/domain/repositories/udp_socket_repo.dart';
import 'package:remote_mouse/domain/usecases/udp_socket_usecase.dart';
import 'package:remote_mouse/presentation/bloc/keyboard_mouse/keyboard_mouse_bloc.dart';
import 'package:remote_mouse/presentation/bloc/udp_socket/udp_socket_bloc.dart';
import 'package:remote_mouse/presentation/bloc/udp_socket/udp_socket_event.dart';
import 'package:remote_mouse/presentation/bloc/udp_socket/udp_socket_state.dart';
import 'package:remote_mouse/services/dep_injection/injection_container.dart';
import 'package:remote_mouse/tab_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Remote Mouse"),
        actions: [
          IconButton(
            onPressed: (){

            },
            icon: Icon(Icons.help,)
          )
        ],
      ),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          spacing: 20,
          children: [
            DefaultTabController(
                length: 1,
                child: TabWidget(titles: ["Computers"])
            ),
            BlocProvider<UDPSocketBloc>(
                create: (context) => UDPSocketBloc(udpSocketUseCase: UDPSocketUseCase(UDPSocketRepoImpl(UDPSocketDatasourceImpl()))),
                child: BlocBuilder<UDPSocketBloc,UDPSocketState>(
                  builder: (context,state){
                    if(state is UDPSocketLoading){
                      return Expanded(child: Center(child: CircularProgressIndicator(
                        color: Colors.blueAccent.shade700,
                      )));
                    }else if(state is UDPSocketLoaded){
                      if(state.devices.isNotEmpty) {
                        return Expanded(
                        child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.3,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                            itemCount: state.devices.length,
                            itemBuilder: (context,index){
                              return BlocProvider<KeyboardMouseBloc>(
                                create: (context) => sl<KeyboardMouseBloc>(),
                                child: RemoteUdpContainer(
                                  key: ValueKey(state.devices[index].name),
                                  remoteDevice: state.devices[index],
                                ),
                              );
                            }
                        ),
                      );
                      } else {
                        return eventFailed(context);
                      }
                    }
                    // else if (state is UDPSocketError) {
                    //   return eventFailed(context);
                    // }
                    else {
                      return eventFailed(context);
                    }
                  },
                )
            ),
          ],
        ),
      // bottomNavigationBar: BottomNavigationBar(
      //     selectedIconTheme: IconThemeData(
      //       color: Colors.blue.shade900
      //     ),
      //     // selectedLabelStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
      //     //   color: Colors.blue.shade800
      //     // ),
      //     items: [
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.home),
      //           backgroundColor: Colors.grey.shade500,
      //           label: "Home",
      //       ),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.assistant_direction,),
      //           label: "Discover",
      //       ),
      //     ]
      // ),
    );
  }


  Widget eventFailed(BuildContext context){
    return  Expanded(
      child: Center(
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No Device Found",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color:Colors.blue.shade600
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade100,
                  foregroundColor: Colors.blueAccent.shade700
              ),
              onPressed: () {
                context.read<UDPSocketBloc>().add(UDPSocketListenEvent());
              },
              child: const Text("Discover Devices"),
            )
          ],
        ),
      ),
    );
  }
}
