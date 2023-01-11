import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: StreamBuilder(
              stream: ref.child(SessionController().userId.toString()).onValue,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  print(SessionController().userId.toString);
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Center(
                            child: Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppColors.secondaryColor,
                                      width: 5)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image(
                                      fit: BoxFit.cover,
                                      image: const NetworkImage(
                                          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      },
                                      errorBuilder: (
                                        context,
                                        object,
                                        stack,
                                      ) {
                                        return Container(
                                            child: const Icon(
                                          Icons.error_outline,
                                          color: AppColors.alertColor,
                                        ));
                                      })),
                            ),
                          )),
                      ReUseAbleRow(
                          title: 'Username',
                          iconData: Icons.person_outline,
                          value: map['username']),
                      ReUseAbleRow(
                          title: 'Email',
                          iconData: Icons.mail_outline_outlined,
                          value: map['email']),
                      ReUseAbleRow(
                          title: 'Phone',
                          iconData: Icons.phone_callback_rounded,
                          value: map['email']),
                    ],
                  );
                } else {
                  return Center(
                      child: Text('Something Went Wrong',
                          style: Theme.of(context).textTheme.subtitle1));
                }
              },
            )),
      ),
    );
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
