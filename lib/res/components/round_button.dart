import 'package:flutter/material.dart';

import '../color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final Color color, textColor;
  final bool loading;
  const RoundButton({
    Key? key,
    required this.title,
    required this.onPress,
    this.color = AppColors.primaryColor,
    this.textColor = AppColors.blackColor,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onPress,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(7)),
          child: loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Center(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 16,
                        color: textColor,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5),
                  ),
                ),
        ),
      ),
    );
  }
}
