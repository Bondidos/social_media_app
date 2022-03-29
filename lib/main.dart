import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/bloc/auth_cubit.dart';
import 'package:social_media_app/pages/post_screen.dart';
import 'package:social_media_app/pages/sign_in_screen.dart';

import 'pages/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (ctx) =>  AuthCubit(),
      child: MaterialApp(
        routes: {
          SignInScreen.id : (ctx) => const SignInScreen(),
          SignUpScreen.id : (ctx) => const SignUpScreen(),
          PostScreen.id : (ctx) => const PostScreen(),
        },
        theme: ThemeData.dark(),
        initialRoute: SignUpScreen.id,
      ),
    );
  }
}
