abstract class KeyboardMouseState {
  const KeyboardMouseState();

}

class KeyboardMouseInitialState extends KeyboardMouseState{
  const KeyboardMouseInitialState();
}

class WebSocketConnectingState extends KeyboardMouseState {
  const WebSocketConnectingState();
}

class WebSocketConnectionSuccessState extends KeyboardMouseState{
  const WebSocketConnectionSuccessState();

}
class WebSocketConnectionErrorState extends KeyboardMouseState {
  const WebSocketConnectionErrorState(this.errorMessage);
  final String errorMessage;
}