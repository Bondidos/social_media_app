import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  static const String id = "create post screen";

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  String _description = "";

  @override
  Widget build(BuildContext context) {
    final File imageFile = ModalRoute.of(context)?.settings.arguments as File;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create post"),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: FileImage(imageFile),
                        fit: BoxFit.cover,
                      )),
                ),
                TextField(
                  decoration: const InputDecoration(
                    hintText: "Enter description",
                  ),
                  textInputAction: TextInputAction.done,

                  // char limits
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(150),
                  ],
                  onChanged: (value) {
                    _description = value;
                  },
                  onEditingComplete: () {
                    _submit(image: imageFile);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit({required File image}) async{
    FocusScope.of(context).unfocus();
    if(_description.trim().isNotEmpty) {
      late String imageUrl;
      // write image to storage
      firebase_storage.FirebaseStorage storage =
          firebase_storage.FirebaseStorage.instance;
      //get firestore ref
      await storage.ref("images/${UniqueKey().toString()}.png").putFile(image)
      .then((taskSnapshot) async {
       imageUrl = await taskSnapshot.ref.getDownloadURL();
      });

      // create new collection firebase
      FirebaseFirestore.instance.collection("posts").add({
        "timestamp" : Timestamp.now(),
        "userId" : FirebaseAuth.instance.currentUser?.uid,
        "description" : _description,
        "userName" : FirebaseAuth.instance.currentUser?.displayName,
       "imageUrl" : imageUrl,
      }).then((docRef) => docRef.update({"postID": docRef.id}));

      Navigator.of(context).pop();
    }
  }
}
