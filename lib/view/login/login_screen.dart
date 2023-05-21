import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/view_model/services/login/login_controller.dart';
import '../../res/components/input_text_field.dart';
import '../../res/components/round_button.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * .017,
                ),

                SvgPicture.asset(
                  'assets/svg/login 1.svg',
                  height: 300,
                  width: 200,
                ),
                Text(
                  'Login to Continue',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 24, fontWeight: FontWeight.w200),
                ),

                // Lottie.asset('assets/lottie/login.json'),
                Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: height * .04, bottom: height * .01),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 15.0, right: 15.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteName.forgotScreen);
                          },
                          child: Text(
                            'Forgot password?',
                            style:
                                Theme.of(context).textTheme.headline1!.copyWith(
                                      fontSize: 15,
                                    ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 15.0, right: 15.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteName.signUpScreen);
                          },
                          child: Text(
                            'New here! Signup',
                            style:
                                Theme.of(context).textTheme.headline1!.copyWith(
                                      fontSize: 15,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
