import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:social_media_app/bloc/auth_cubit.dart';
import 'package:social_media_app/pages/chat_screen.dart';
import 'package:social_media_app/pages/create_post_screen.dart';
import 'package:social_media_app/pages/post_screen.dart';
import 'package:social_media_app/pages/sign_in_screen.dart';

import 'pages/sign_up_screen.dart';

void main() async {
  await SentryFlutter.init((options) {
    options.dsn =
        'https://f6b6c5618d974aad81b49968e83c365a@o1184325.ingest.sentry.io/6301888';
    options.tracesSampleRate = 1.0;
  }, appRunner: () async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget _buildHomeScreen() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          return const PostScreen();
        } else {
          return const SignInScreen();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (ctx) => AuthCubit(),
      child: MaterialApp(
        routes: {
          SignInScreen.id: (ctx) => const SignInScreen(),
          SignUpScreen.id: (ctx) => const SignUpScreen(),
          PostScreen.id: (ctx) => const PostScreen(),
          CreatePostScreen.id: (ctx) => const CreatePostScreen(),
          ChatScreen.id: (ctx) => const ChatScreen(),
        },
        theme: ThemeData.dark(),
        home: _buildHomeScreen(),
      ),
    );
  }
}
