import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/view_model/services/profile/profile_controller.dart';

import '../../res/color.dart';
import '../../view_model/services/session_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ref = FirebaseDatabase.instance.ref('Users');
  String? check = SessionController().userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: ChangeNotifierProvider(
          create: (_) => ProfileController(),
          child: Consumer<ProfileController>(
            builder: (context, provider, child) {
              return SafeArea(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    height: 220,
                                    width: 180,
                                    child: Lottie.asset(
                                        'assets/lottie/circle.json'),
                                  ),
                                  Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: AppColors.primaryColor,
                                            width: 1.2)),
                                    child: InkWell(
                                        onTap: () {
                                          provider.pickImage(context);
                                        },
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: provider.image == null
                                                ? map['profile'].toString() ==
                                                        ""
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
                                                              null)
                                                            return child;
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
                                  const Padding(
                                    padding: EdgeInsets.only(top: 120.0),
                                    child: CircleAvatar(
                                      backgroundColor: AppColors.primaryColor,
                                      radius: 11,
                                      child: Icon(
                                        Icons.add,
                                        size: 15,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  provider.userNameDialogAlert(
                                      context, map['username']);
                                },
                                child: ReUseAbleRow(
                                    title: 'Username',
                                    iconData: Icons.person_outline,
                                    value: map['username']),
                              ),
                              ReUseAbleRow(
                                  title: 'Email',
                                  iconData: Icons.mail_outline_outlined,
                                  value: map['email']),
                              GestureDetector(
                                onTap: () {
                                  provider.showPhoneDialogAlert(
                                      context, map['phone']);
                                },
                                child: ReUseAbleRow(
                                    title: 'Phone',
                                    iconData: Icons.phone_callback_rounded,
                                    value: map['phone']),
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
  final IconData iconData;
  const ReUseAbleRow({
    Key? key,
    required this.title,
    required this.iconData,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          leading: Icon(iconData),
          trailing: Text(value),
        ),
        Divider(
          color: AppColors.dividedColor.withOpacity(0.4),
        )
      ],
    );
  }
}
