import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/color.dart';
import '../widget/name_textfeild.dart';

class SearchUser extends StatefulWidget {
  static const routeName = '/SearchScreen';

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  TextEditingController searchTxt = TextEditingController();

  var search = TextEditingController();

  List<dynamic> options = [];
  List<dynamic> filteredOptions = [];

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  Widget getListItem(Size size, dynamic element) {
    return GestureDetector(
      // onTap: () {
      //   Get.toNamed(SearchResults.routeName, arguments: element);
      // },
      child: Container(
        margin: EdgeInsets.only(
            left: size.width * 0.05,
            right: size.width * 0.05,
            bottom: size.height * 0.01231),
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.053,
          vertical: size.height * 0.02,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: size.height * 0.0,
              blurRadius: size.height * 0.01,
              offset: Offset(0, 1),
              color: AppColors.black.withOpacity(0.1),
            )
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(size.width * 0.012),
          ),
          color: AppColors.whiteColor,
        ),
        child: Text(
          element,
          style: TextStyle(
            fontSize: size.height * 0.0172,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.primaryColor,
            padding: EdgeInsets.only(
                left: size.width * 0.05,
                bottom: size.height * 0.01,
                right: size.width * 0.05),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                      child: CustomTextField(
                          textEditingController: searchTxt,
                          prefixIcon: Icon(Icons.search),
                          hint: 'Search',
                          isfillColorWhite: true,
                          onChange: (value) {
                            if (value != '') {
                              filteredOptions.clear();
                              filteredOptions.addAll(
                                options.where((element) => element
                                    .toLowerCase()
                                    .contains(value.toLowerCase())),
                              );
                            } else {
                              filteredOptions.clear();
                            }

                            setState(() {});

                            _focusNode.requestFocus();
                          })),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: size.height * 0.019,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
          filteredOptions.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: filteredOptions.length,
                    itemBuilder: (context, index) =>
                        getListItem(size, filteredOptions.elementAt(index)),
                  ),
                )
              : Expanded(
                  child: Container(),
                ),
        ],
      ),
    );
  }
}
