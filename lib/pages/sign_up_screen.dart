import 'package:flutter/material.dart';
import 'package:social_media_app/pages/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static const String id = "sign up screen";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _userName = "";
  String _password = "";

  late final FocusNode _passwordFocusNode;
  late final FocusNode _userNameFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    _userNameFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _userNameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Text(
                      "Social Media App",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //email
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                        labelText: "Enter your email",
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_){
                      FocusScope.of(context).requestFocus(_userNameFocusNode);
                    },
                    onSaved: (value){
                      _email = value!.trim();
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter your email";
                      }
                      return null;
                    },
                  ),
                  //username
                  TextFormField(
                    focusNode: _userNameFocusNode,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: "Enter your username",
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_){
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    onSaved: (value){
                      _userName = value!.trim();
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter your username";
                      }
                      return null;
                    },
                  ),
                  //password
                  TextFormField(
                    focusNode: _passwordFocusNode,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: "Enter your password",
                    ),
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_){
                      //todo submit form
                    },
                    onSaved: (value){
                      _password = value!.trim();
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter your password";
                      }
                      if(value.length < 5){
                        return "Please enter your password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextButton(
                    onPressed: () {
                      //todo submit form

                    },
                    child: const Text("Sign Up"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(SignInScreen.id);
                    },
                    child: const Text("Sign in instead"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
