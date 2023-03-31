// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:tech_media/res/components/input_text_field.dart';
// import 'package:tech_media/res/components/round_button.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
// import 'package:flutter/material.dart';
//
// final user = FirebaseAuth.instance.currentUser;
// final userID = user?.uid;
// final displayName = user?.email;
//
// class CallWithInv extends StatefulWidget {
//   const CallWithInv({Key? key}) : super(key: key);
//
//   @override
//   State<CallWithInv> createState() => _CallWithInvState();
// }
//
// class _CallWithInvState extends State<CallWithInv> {
//   final TextEditingController callingId = TextEditingController();
//   final FocusNode userNameFocusNode = FocusNode();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/images/call.png',
//                 width: MediaQuery.of(context).size.width * 0.7,
//               ),
//               InputTextField(
//                   myController: callingId,
//                   focusNode: userNameFocusNode,
//                   onFieldSubmittedValue: (value) {},
//                   keyBoardType: TextInputType.emailAddress,
//                   obscureText: false,
//                   hint: 'Enter App Id',
//                   onValidator: (value) {
//                     return value.isEmpty ? 'enter App Id' : null;
//                   }),
//               RoundButton(
//                 title: 'Join Call',
//                 onPress: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => CallInvitationPage()));
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class CallInvitationPage extends StatelessWidget {
//   const CallInvitationPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ZegoUIKitPrebuiltCallWithInvitation(
//       appID: 865675497,
//       appSign:
//       '446e63e71d94879525f97ddc3c91f8c7fd157538c06a127d28ff816b9db2835f',
//       userID: userID.toString(),
//       userName: displayName.toString(),
//       plugins: [ZegoUIKitSignalingPlugin()],
//       requireConfig: (ZegoCallInvitationData data) {
//         print(userID);
//         var config = (data.invitees.isNotEmpty)
//             ? ZegoCallType.videoCall == data.type
//             ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
//             : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
//             : ZegoCallType.videoCall == data.type
//             ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
//             : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();
//
//         // Modify your custom configurations here.
//         config.layout = ZegoLayout.pictureInPicture(
//           //showMyViewWithVideoOnly: false,
//           isSmallViewDraggable: true,
//           switchLargeOrSmallViewByClick: true,
//         );
//         return config;
//       },
//       child: Container(),
//     );
//   }
// }
