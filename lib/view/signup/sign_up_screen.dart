import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';

import '../../res/components/input_text_field.dart';
import '../../res/components/round_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final userNameFocusNode = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    userNameFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * .05,
                ),
                Text(
                  'Welcome To COMTACH',
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: height * .01,
                ),
                Text(
                  'Enter Your Credentials To Create Account',
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height * .01,
                ),
                Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: height * .06, bottom: height * .01),
                      child: Column(
                        children: [
                          InputTextField(
                              myController: emailController,
                              focusNode: emailFocusNode,
                              onFieldSubmittedValue: (value) {},
                              keyBoardType: TextInputType.emailAddress,
                              obscureText: false,
                              hint: 'Username',
                              onValidator: (value) {
                                return value.isEmpty ? 'enter username' : null;
                              }),
                          SizedBox(
                            height: height * 0.01,
                          ),
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
                          SizedBox(
                            height: height * 0.01,
                          ),
                          InputTextField(
                              myController: passwordController,
                              focusNode: passwordFocusNode,
                              onFieldSubmittedValue: (value) {},
                              keyBoardType: TextInputType.emailAddress,
                              obscureText: false,
                              hint: 'Password',
                              onValidator: (value) {
                                return value.isEmpty ? 'enter password' : null;
                              }),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 30,
                ),
                RoundButton(
                  title: 'Sign Up',
                  onPress: () {},
                  //  loading: true,
                ),
                const SizedBox(
                  height: 18,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.loginView);
                  },
                  child: Text.rich(
                    TextSpan(text: 'Already have an account? ', children: [
                      TextSpan(
                        text: 'Login',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 15, decoration: TextDecoration.underline),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
