import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view_model/services/signup/signup_controller.dart';

import '../../res/components/input_text_field.dart';
import '../../res/components/round_button.dart';
import '../../utils/utils.dart';

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
        title: Text(
          'Welcome',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontSize: 28, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: ChangeNotifierProvider(
                create: (_) => SignUpController(),
                child: Consumer<SignUpController>(
                  builder: (context, provider, child) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * .017,
                          ),
                          SvgPicture.asset(
                            'assets/svg/signup 1.svg',
                            height: 280,
                            width: 190,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 18.0),
                            child: Text(
                              'New Here! Sign Up to Continue',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w200),
                            ),
                          ),
                          Form(
                              key: _formKey,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: height * .001, bottom: height * .001),
                                child: Column(
                                  children: [
                                    InputTextField(
                                        myController: userNameController,
                                        focusNode: userNameFocusNode,
                                        onFieldSubmittedValue: (value) {},
                                        keyBoardType:
                                            TextInputType.emailAddress,
                                        obscureText: false,
                                        hint: 'Username',
                                        onValidator: (value) {
                                          return value.isEmpty
                                              ? 'Enter Username!'
                                              : null;
                                        }),
                                    SizedBox(
                                      height: height * 0.007,
                                    ),
                                    InputTextField(
                                        myController: emailController,
                                        focusNode: emailFocusNode,
                                        onFieldSubmittedValue: (value) {
                                          Utils.fieldFocus(
                                              context,
                                              emailFocusNode,
                                              passwordFocusNode);
                                        },
                                        keyBoardType:
                                            TextInputType.emailAddress,
                                        obscureText: false,
                                        hint: 'Email',
                                        onValidator: (value) {
                                          return value.isEmpty
                                              ? 'Enter Email!'
                                              : null;
                                        }),
                                    SizedBox(
                                      height: height * 0.007,
                                    ),
                                    InputTextField(
                                        myController: passwordController,
                                        focusNode: passwordFocusNode,
                                        onFieldSubmittedValue: (value) {},
                                        keyBoardType:
                                            TextInputType.emailAddress,
                                        obscureText: true,
                                        hint: 'Password',
                                        onValidator: (value) {
                                          return value.isEmpty
                                              ? 'Enter Password!'
                                              : null;
                                        }),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          RoundButton(
                            loading: provider.loading,
                            title: 'Sign Up',
                            onPress: () {
                              if (_formKey.currentState!.validate()) {
                                provider.signup(
                                  context,
                                  userNameController.text.toString(),
                                  emailController.text.toString(),
                                  passwordController.text.toString(),
                                );
                              }
                            },
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
                              TextSpan(text: 'Already a member? ', children: [
                                TextSpan(
                                  text: 'Login',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                          fontSize: 15,
                                          decoration: TextDecoration.underline),
                                ),
                              ]),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ))),
      ),
    );
  }
}
