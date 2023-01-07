import 'package:flutter/material.dart';

import '../../res/components/round_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RoundButton(
            title: 'Login',
            onPress: () {},
            // loading: true,
          )
        ],
      ),
    );
  }
}
