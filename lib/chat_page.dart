import 'dart:async';

import 'package:demo_chat/chat_model.dart';
import 'package:demo_chat/notification.dart';
import 'package:demo_chat/socket_chat.dart';
import 'package:flutter/material.dart';

bool isInChat = false;

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final socket = SocketChat();

  List<MessageModel> messages = [];

  @override
  void initState() {
    isInChat = true;
    socket.connectToSocket();
    socket.messageStream.listen((data) {
      if (!isInChat) {
        final content = MessageModel.fromMap(data as Map<String, dynamic>);
        NotificationApp.showMessageNoti(content.message);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat")),
      body: StreamBuilder(
        stream: socket.messageStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            messages.add(
                MessageModel.fromMap(snapshot.data as Map<String, dynamic>));
          }
          return ListView.separated(
            itemCount: messages.length,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            },
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(messages[index].userName),
                subtitle: Text(messages[index].message),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        // chatStreamController.sink.add(false);
        // isInChat = false;
       
      }),
    );
  }
}
