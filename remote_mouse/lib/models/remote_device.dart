class RemoteDevice {
  int port;
  String address;
  String name;

  RemoteDevice({required this.port, required this.address, required this.name});

  factory RemoteDevice.fromJson(Map<String,dynamic> json){
    return RemoteDevice(
      port: json["port"],
      address: json["address"],
      name: json["name"],
    );
  }


}