import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart';

class SocketChat {
  static final _instance = SocketChat._private();
  final eventTakeBooking = 'take-booking';
  final _socketResponse = StreamController<dynamic>.broadcast();
  Stream get messageStream => _socketResponse.stream;
  int amountReconnect = 0;
  bool _isConnected = false;
  // late StreamSubscription<ConnectivityResult> subscription;
  factory SocketChat() {
    return _instance;
  }
  SocketChat._private();
  late Socket _socket;

  void connectToSocket() async {
    print("Init socket...");
    _socket = io(
      // TODO: Chạy ifconfig trên Mac để lấy địa chỉ ip gắn vào đường dẫn này
        "http://10.50.10.67:3000",
        OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    print("Starting connect to socket...");
    _socket.connect();
    _socket.onConnect((data) {
      _isConnected = true;
      print("Socket connected...");
      joinRoomChat("Vi lang");

      _socket.on("message", (data) {
        print(data);
        _socketResponse.sink.add(data);
      });
    });
    _socket.onDisconnect((data) {
      amountReconnect++;
      _isConnected = false;
      print("Socket disconnect...");
      if (amountReconnect <= 5) {
        reConnect();
      }
    });
  }

  void onCheckout() {
    if (_isConnected) {
      print("On listening checkin...");
      _socket.on(eventTakeBooking, (data) {
        print(data);
        _socketResponse.sink.add(data);
      });
    }
  }

  void reConnect() async {
    print("onReconnect...");
    connectToSocket();
  }

  void joinRoomChat(String userName) {
    _socket.emit("joinRoom", {
      "username": userName,
      "room": "CSKH",
      "isAdmin1": false,
    });
  }

  void closeSocket() {
    _socket.close();
    _socketResponse.close();
    // subscription.cancel();
  }
}
