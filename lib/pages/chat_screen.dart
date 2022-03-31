import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/models/post_model.dart';

import '../models/chat_model.dart';
import '../widgets/message_list_tile.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const id = "chat screen";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  String _message = "";
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Post post = ModalRoute.of(context)!.settings.arguments as Post;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("posts")
                      .doc(post.id)
                      .collection("comments")
                      .orderBy("timeStamp")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Error"),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.connectionState == ConnectionState.none) {
                      return const Center(
                        child: Text("Loading"),
                      );
                    }

                    return ListView.builder(
                      itemCount: snapshot.data?.docs.length ?? 0,
                      itemBuilder: (ctx, index) {
                        final QueryDocumentSnapshot doc =
                            snapshot.data!.docs[index];

                        final ChatModel chatModel = ChatModel(
                          userName: doc["userName"],
                          userId: doc["userId"],
                          message: doc["message"],
                          timestamp: doc["timeStamp"],
                        );

                        return Align(
                            alignment: (chatModel.userId == currentUserId)
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: MessageTile(chatModel: chatModel));
                      },
                    );
                  }),
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: TextField(
                        controller: _controller,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          hintText: "Enter message",
                        ),
                        onChanged: (value) {
                          _message = value;
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("posts")
                          .doc(post.id)
                          .collection("comments")
                          .add({
                            "userId": FirebaseAuth.instance.currentUser!.uid,
                            "userName":
                                FirebaseAuth.instance.currentUser!.displayName,
                            "message": _message,
                            "timeStamp": Timestamp.now(),
                          })
                          .then((value) => print("chat Doc Added"))
                          .catchError((onError) => print(
                              "Error has occurred while adding chat doc"));

                      _controller.clear();

                      setState(() {
                        _message = "";
                      });
                    },
                    icon: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
