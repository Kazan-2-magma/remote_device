import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remote_mouse/models/keybaord_model.dart';
import 'package:remote_mouse/presentation/bloc/keyboard_mouse/keyboard_mouse_bloc.dart';
import 'package:remote_mouse/presentation/bloc/keyboard_mouse/keyboard_mouse_event.dart';

class PcKeyboard extends StatefulWidget {
  const PcKeyboard({super.key, required this.keyboardMouseBloc});
  final KeyboardMouseBloc keyboardMouseBloc;

  @override
  State<PcKeyboard> createState() => _PcKeyboardState();
}

class _PcKeyboardState extends State<PcKeyboard> {

  bool ctrlPressed = false;
  bool shiftPressed = false;
  bool altPressed = false;
  bool capsLock = false;


  late List<Widget> keysCapsOff;
  late List<Widget> keysCapsOn;

  void _toggle(){
    setState(() {
      capsLock = !capsLock;
    });
  }


  @override
  void initState() {
    super.initState();

    keysCapsOn = [
      buildRow([
        "`",
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "0",
        "-",
        "=",
        "Backspace",
        "HOME"
      ]),
      buildRow([
        "Tab",
        "Q",
        "W",
        "E",
        "R",
        "T",
        "Y",
        "U",
        "I",
        "O",
        "P",
        "[",
        "]",
        "\\",
        "PGUP"
      ]),
      buildRow([
        "Caps",
        "A",
        "S",
        "D",
        "F",
        "G",
        "H",
        "J",
        "K",
        "L",
        ";",
        "'",
        "Enter",
        "PGDN"
      ]),
      buildRow([
        "Shift",
        "Z",
        "X",
        "C",
        "V",
        "B",
        "N",
        "M",
        ",",
        ".",
        "/",
        "Shift",
        "↑",
        "END"
      ]),
    ];

    keysCapsOff = [
      buildRow([
        "`",
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "0",
        "-",
        "=",
        "Backspace",
        "HOME"
      ]),
      buildRow([
        "Tab",
        "q",
        "w",
        "e",
        "r",
        "t",
        "y",
        "u",
        "i",
        "o",
        "p",
        "[",
        "]",
        "\\",
        "PGUP"
      ]),
      buildRow([
        "Caps",
        "a",
        "s",
        "d",
        "f",
        "g",
        "h",
        "j",
        "k",
        "l",
        ";",
        "'",
        "Enter",
        "PGDN"
      ]),
      buildRow([
        "Shift",
        "z",
        "x",
        "c",
        "v",
        "b",
        "n",
        "m",
        ",",
        ".",
        "/",
        "Shift",
        "↑",
        "END"
      ]),
    ];

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.keyboardMouseBloc,
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SafeArea(
          left: false,
          right: false,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                buildRow([
                  "Esc",
                  "F1",
                  "F2",
                  "F3",
                  "F4",
                  "F5",
                  "F6",
                  "F7",
                  "F8",
                  "F9",
                  "F10",
                  "F11",
                  "F12"
                ]),
                if(capsLock)
                  ...keysCapsOn,
                if(!capsLock)
                  ...keysCapsOff,
                buildRow(["Ctrl", "Win", "Alt", "Space", "Alt", "Win", "Menu", "Ctrl","←", "↓", "→"]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  EdgeInsetsGeometry specialKeys(String key){
    if(key == "Shift" || key == "Enter" ){
      return EdgeInsetsGeometry.symmetric(horizontal: 50,vertical: 15);
    }else if(key == "Space"){
      return EdgeInsetsGeometry.symmetric(horizontal: 100,vertical: 15);
    }else if(key == "Caps"){
      return EdgeInsetsGeometry.symmetric(horizontal: 20,vertical: 15);
    }
      return EdgeInsetsGeometry.all(15);
  }

  String normalizeKey(String key) {
    switch (key.toLowerCase()) {
      case "win":
      case "cmd":
      case "super":
        return "command"; // RobotGo uses "command" (mac) or "super" (linux)
      case "↑": return "up";
      case "↓": return "down";
      case "←": return "left";
      case "→": return "right";
      case "HOME":
        return "home";
      case "end":
        return "end";
      case "PGUP":
        return "pageup";
      case "PGDN":
        return "pagedown";
      default:
        return key;
    }
  }

  void sendKey(String key) {
    print("Clicked");

    if(key == "Caps"){
      _toggle();
    }

    final modifiers = <String>[];
    if (ctrlPressed) modifiers.add("ctrl");
    if (shiftPressed) modifiers.add("shift");
    if (altPressed) modifiers.add("alt");

    widget.keyboardMouseBloc.add(
      KeyboardDataSentEvent(KeyboardModel(
        key: normalizeKey(key),
        modifiers: modifiers
      )),
    );

    print(modifiers);

    if (shiftPressed && key != "Shift") {
      setState(() => shiftPressed = false);
    }
  }


  Widget buildKey(String key) {

    final isModifier = ["Ctrl", "Shift", "Alt"].contains(key);

    if (isModifier) {
      final active = (key == "Ctrl" && ctrlPressed) ||
          (key == "Shift" && shiftPressed) ||
          (key == "Alt" && altPressed);

      return GestureDetector(
        onTap: () {
          setState(() {
            if (key == "Ctrl") ctrlPressed = !ctrlPressed;
            if (key == "Shift") shiftPressed = !shiftPressed;
            if (key == "Alt") altPressed = !altPressed;
          });
        },
        child: Container(
          padding: specialKeys(key),
          decoration: BoxDecoration(
            color: active ? Colors.blue : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(key),
        ),
      );
    }

    // Normal key
    return GestureDetector(
      onTap: () => sendKey(key),
      child: Container(
        padding: specialKeys(key),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(key),
      ),
    );
  }



  Widget buildModifierKey(String label, VoidCallback onToggle, bool isActive) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(label, style: const TextStyle(fontSize: 16)),
      ),
    );
  }


  Widget buildRow(List<String> keys) {
    return Expanded(
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 5,
        runSpacing: 4,
        children: keys.map(buildKey).toList(),
      ),
    );
  }

}

