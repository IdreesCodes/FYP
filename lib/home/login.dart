import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: const Icon(
                    Icons.settings,
                    size: 26.0,
                    color: Colors.black38
                ),
              ),
            ],
          ),



        ],
      ),
    );
  }
}
