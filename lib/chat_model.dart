class MessageModel {
  String userName;
  String message;
  String time;
  MessageModel({
    required this.userName,
    required this.message,
    required this.time,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
        userName: map['username'] ?? '',
        message: map['text'] ?? '',
        time: map['time']);
  }
}
