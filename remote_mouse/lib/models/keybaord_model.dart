class KeyboardModel {
  final String action;
  final String key;
  final List<String> modifiers;

  const KeyboardModel({this.action = "KEY",required this.key,this.modifiers = const []});

}