import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/view_model/services/login/login_controller.dart';
import '../../res/components/input_text_field.dart';
import '../../res/components/round_button.dart';
import 'package:tech_media/view_model/services/login/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
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
                SvgPicture.asset(
                  'assets/svg/login.svg',
                  height: 300,
                  width: 200,
                ),
                // Lottie.asset('assets/lottie/login.json'),
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

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.forgotScreen);
                    },
                    child: Text(
                      'Forgot password?',
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 13, decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ChangeNotifierProvider(
                  create: (_) => LoginController(),
                  child: Consumer<LoginController>(
                    builder: (context, provider, child) {
                      return RoundButton(
                        loading: provider.loading,
                        title: 'Login',
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            provider.login(context, emailController.text,
                                passwordController.text);
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.signUpScreen);
                  },
                  child: Text.rich(
                    TextSpan(text: 'Don\'t have an account? ', children: [
                      TextSpan(
                        text: 'Signup',
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
