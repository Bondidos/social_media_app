import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/chat_model.dart';

class MessageTile extends StatelessWidget {
  MessageTile({
    Key? key,
    required this.chatModel,
  }) : super(key: key);

  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: chatModel.userId == currentUserId
                ? const Radius.circular(15)
                : Radius.zero,
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomRight: chatModel.userId == currentUserId
                ? Radius.zero
                : const Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: chatModel.userId == currentUserId
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment: chatModel.userId == currentUserId
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Text(
                "By ${chatModel.userName}",
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                chatModel.message,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
