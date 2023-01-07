import 'package:flutter/material.dart';

import '../../res/components/input_text_field.dart';
import '../../res/components/round_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final emailFocusNode = FocusNode();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputTextField(
                myController: emailController,
                focusNode: emailFocusNode,
                onFieldSubmittedValue: (value) {},
                keyBoardType: TextInputType.emailAddress,
                obscureText: false,
                hint: 'Email',
                onValidator: (value) {
                  return value.isEmpty ? 'enter email' : null;
                }),
            RoundButton(
              title: 'Login',
              onPress: () {},
              loading: true,
            )
          ],
        ),
      ),
    );
  }
}
