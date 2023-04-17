import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import 'package:tech_media/view/login/login_screen.dart';
import 'package:tech_media/view_model/services/profile/profile_controller.dart';

import '../../res/color.dart';
import '../../utils/routes/route_name.dart';
import '../../view_model/services/session_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  final ref = FirebaseDatabase.instance.ref('Users');

  String? check = SessionController().userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: ChangeNotifierProvider(
          create: (_) => ProfileController(),
          child: Consumer<ProfileController>(
            builder: (context, provider, child) {
              return SafeArea(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: StreamBuilder(
                      stream: ref
                          .child(SessionController().userId.toString())
                          .onValue,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          print(SessionController().userId.toString);
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasData) {
                          Map<dynamic, dynamic> map =
                              snapshot.data.snapshot.value;
                          return Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                child: Image.asset(
                                  'assets/images/Mask group.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 70,
                                child: Text(
                                  'Profile Screen',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                ),
                              ),
                              Positioned(
                                top: 120,
                                left: 120,
                                child: Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 2.3)),
                                  child: InkWell(
                                      onTap: () {
                                        provider.pickImage(context);
                                      },
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: provider.image == null
                                              ? map['profile'].toString() == ""
                                                  ? const Icon(
                                                      Icons.person_2_outlined,
                                                      size: 30,
                                                    )
                                                  : Image(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          map["profile"]
                                                              .toString()),
                                                      loadingBuilder: (context,
                                                          child,
                                                          loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) return child;
                                                        return const Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      },
                                                      errorBuilder: (
                                                        context,
                                                        object,
                                                        stack,
                                                      ) {
                                                        return Container(
                                                            child: const Icon(
                                                          Icons.error_outline,
                                                          color: AppColors
                                                              .alertColor,
                                                        ));
                                                      })
                                              : Image.file(
                                                  File(provider.image!.path)
                                                      .absolute))),
                                ),
                              ),
                              const Positioned(
                                top: 80,
                                left: 218,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 120.0),
                                  child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 11,
                                      child: Image(
                                          image: AssetImage(
                                              'assets/images/Photo Editor.png'))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16.0,
                                  right: 16,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 265,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        provider.userNameDialogAlert(
                                            context, map['username']);
                                      },
                                      child: ReUseAbleRow(
                                        title: 'Username',
                                        imageData: Image.asset(
                                            'assets/images/Person.png'),
                                        value: map['username'],
                                      ),
                                    ),
                                    ReUseAbleRow(
                                        title: 'Email',
                                        imageData: Image.asset(
                                            'assets/images/Shake Phone.png'),
                                        value: map['email']),
                                    GestureDetector(
                                      onTap: () {
                                        provider.showPhoneDialogAlert(
                                            context, map['phone']);
                                      },
                                      child: ReUseAbleRow(
                                          title: 'Phone',
                                          imageData: Image.asset(
                                              'assets/images/Group Message.png'),
                                          value: map['phone']),
                                    ),
                                    const SizedBox(
                                      height: 120,
                                    ),
                                    const Text('Comtech All Rights Reserved'),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        left: 12.0,
                                        right: 12,
                                      ),
                                      child: Divider(
                                        height: 1,
                                        color: Colors.black,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        signOut();
                                        PersistentNavBarNavigator.pushNewScreen(
                                          context,
                                          screen: LoginScreen(),
                                          withNavBar: false,
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12.0, right: 12, top: 15),
                                        child: Container(
                                          width: double.infinity,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                          child: Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0,
                                                    top: 20,
                                                    bottom: 14,
                                                    right: 4),
                                                child: Image.asset(
                                                    'assets/images/Vector.png'),
                                              ),
                                              Text(
                                                'Logout',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2!
                                                    .copyWith(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        letterSpacing: 1.5),
                                              ),
                                            ],
                                          )),
                                        ),
                                      ),
                                    ),
                                    // TextFormField(
                                    //   controller: controller,
                                    //   decoration: InputDecoration(
                                    //       border: OutlineInputBorder(
                                    //         borderRadius:
                                    //             BorderRadius.circular(10.0),
                                    //       ),
                                    //       filled: true,
                                    //       fillColor: Colors.white,
                                    //       hintText: 'Change Password'),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Center(
                              child: Text('Something Went Wrong',
                                  style:
                                      Theme.of(context).textTheme.subtitle1));
                        }
                      },
                    )),
              );
            },
          ),
        ));
  }
}

class ReUseAbleRow extends StatelessWidget {
  final String title, value;

  final Image imageData;
  const ReUseAbleRow(
      {Key? key,
      required this.title,
      required this.value,
      required this.imageData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black, width: 0.7),
                borderRadius: BorderRadius.circular(7)),
            child: ListTile(
              title: Text(title),
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(2, 15, 0, 15),
                child: imageData,
              ),
              trailing: Text(value),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
