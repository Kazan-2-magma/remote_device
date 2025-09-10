enum WebSocketConnectionStatus {

  connected("CONNECTED"),
  failed("FAILED"),
  closed("closed");


  const WebSocketConnectionStatus(this.status);
  final String status;



}