import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/bloc/auth_cubit.dart';
import 'package:social_media_app/pages/sign_in_screen.dart';

import 'create_post_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);
  static const String id = "posts_screen";

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                final picker = ImagePicker();
                picker
                    .pickImage(source: ImageSource.gallery, imageQuality: 40)
                    .then((xFile) {
                  if (xFile != null) {
                    final File file = File(xFile.path);
                    Navigator.of(context)
                        .pushNamed(CreatePostScreen.id, arguments: file);
                  }
                });
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () {
                context.read<AuthCubit>().signOut().then((value) =>
                    Navigator.pushReplacementNamed(context, SignInScreen.id));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: ListView.builder(
        itemCount: 0,
        itemBuilder: (context, index) {
          return Container();
        },
      ),
    );
  }
}
