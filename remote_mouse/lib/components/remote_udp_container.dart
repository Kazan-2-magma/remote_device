import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remote_mouse/components/navigation.dart';
import 'package:remote_mouse/models/remote_device.dart';
import 'package:remote_mouse/presentation/bloc/keyboard_mouse/keyboard_mouse_bloc.dart';
import 'package:remote_mouse/presentation/bloc/keyboard_mouse/keyboard_mouse_event.dart';
import 'package:remote_mouse/presentation/bloc/keyboard_mouse/keyboard_mouse_state.dart';
import 'package:remote_mouse/presentation/views/hid_devices_screen.dart';
import 'package:remote_mouse/services/dep_injection/injection_container.dart';
import 'package:remote_mouse/tab_widget.dart';


class RemoteUdpContainer extends StatelessWidget {
  const RemoteUdpContainer({Key? key, required this.remoteDevice}) : super(key: key);
  final RemoteDevice remoteDevice;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(remoteDevice.address);
        context.read<KeyboardMouseBloc>().add(WebSocketConnectionEvent(remoteDevice));
      },
      child: Container(
        padding: EdgeInsets.all(5),
        width: 100,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black,blurRadius: 1)
            ],
            gradient: LinearGradient(
                end: Alignment.bottomRight,
                begin: Alignment.topLeft,
                colors: [
                  Colors.grey.shade400,
                  Colors.grey.shade300,
                ]
            ),
            // color: Colors.grey.shade300,
            borderRadius: BorderRadius.all(Radius.circular(16))
        ),
        child: Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SvgPicture.asset(
              "assets/images/laptop.svg",
                width: 60,
            ),
            BlocConsumer<KeyboardMouseBloc,KeyboardMouseState>(
              listener: (context,state){
                if(state is WebSocketConnectionErrorState){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(state.errorMessage),
                    ),
                  );
                }else if(state is WebSocketConnectionSuccessState){

                  final bloc = context.read<KeyboardMouseBloc>();

                  CustomNavigation.go(context, HidDevicesScreen(
                      remoteDevice: remoteDevice,
                      keyboardMouseBloc: bloc,
                  ));
                }
              },
                builder: (context,state){
                  if(state is WebSocketConnectingState){
                    return Center(
                      child:Row(
                        spacing: 20,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Connecting...",
                            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: Colors.grey.shade600
                            ),
                          ),
                          SizedBox(
                            width: 18,height: 18,
                            child: const CircularProgressIndicator(
                              color: Colors.blue,
                              strokeWidth: 2,
                            ),
                          ),
                        ],
                      )
                    );
                  }else {
                    print("Nothins");

                    return Text(
                      remoteDevice.name,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.grey.shade800
                      ),
                      overflow: TextOverflow.ellipsis,
                    );
                  }
                }
            ),
          ],
        ),
      ),
    );
  }
}
