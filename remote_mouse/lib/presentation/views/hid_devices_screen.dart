import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remote_mouse/components/action_button.dart';
import 'package:remote_mouse/components/expandable_fab.dart';
import 'package:remote_mouse/components/navigation.dart';
import 'package:remote_mouse/models/mouse_data_model.dart';
import 'package:remote_mouse/models/remote_device.dart';
import 'package:remote_mouse/presentation/bloc/keyboard_mouse/keyboard_mouse_bloc.dart';
import 'package:remote_mouse/presentation/bloc/keyboard_mouse/keyboard_mouse_event.dart';
import 'package:remote_mouse/enums/mouse_action.dart';
import 'package:remote_mouse/presentation/views/pc_keyboard.dart';

class HidDevicesScreen extends StatelessWidget {
  const HidDevicesScreen({super.key, required this.remoteDevice, required this.keyboardMouseBloc});

  final RemoteDevice remoteDevice;
  final KeyboardMouseBloc keyboardMouseBloc;


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: keyboardMouseBloc,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
              remoteDevice.name,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.blue.shade700
              ),
          ),
        ),
        body: Stack(
          children: [
            GestureDetector(
              onPanUpdate: (details){

                keyboardMouseBloc.add(MouseDataSentEvent(MouseDataModel(
                  MouseAction.move.action,
                  dx:  details.delta.dx,
                  dy : details.delta.dy,
                )));

              },
              onTap: (){
                keyboardMouseBloc.add(MouseDataSentEvent(MouseDataModel(MouseAction.click.action)));
              },
              onDoubleTap: (){
                keyboardMouseBloc.add(MouseDataSentEvent(MouseDataModel(
                    MouseAction.rightClick.action
                )));
              },
            ),
          ],
        ),
        floatingActionButton: ExpandableFab(
            distance: 90,
            children:[
              ActionButton(
                onPressed: () => CustomNavigation.go(context,PcKeyboard(keyboardMouseBloc: keyboardMouseBloc)),
                icon: const Icon(Icons.keyboard,color: Colors.black87,),
              ),
              ActionButton(
                onPressed: () => print("line"),
                icon: const Icon(Icons.power_settings_new_rounded,color: Colors.black87,),
              ),

            ]
        )
      ),
    );
  }
}
