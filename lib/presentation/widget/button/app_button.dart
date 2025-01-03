// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/core/constant/dimensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';

DateTime? _lastOnPressTime;

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final bool isEnable;
  final bool isCheckLastPress;
  final double radius;
  final bool isHaveColor;
  final bool isSafeArea;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final BorderSide? borderSide;
  final double? height;
  final bool isLoading;
  final Color? textColor;
  const AppButton(
      {super.key,
      this.onPressed,
      required this.text,
      this.isEnable = false,
      this.isHaveColor = true,
      this.isCheckLastPress = true,
      this.radius = 8,
      this.isSafeArea = true,
      this.isLoading = false,
      this.padding,
      this.margin,
      this.backgroundColor = AppColors.primary,
      this.textColor,
      this.borderSide,
      this.height});
  @override
  Widget build(BuildContext context) {
    final colorEnable = isEnable ? (backgroundColor) : AppColors.color8E8;
    final colorEnableDarkMode = isEnable ? backgroundColor : AppColors.color8E8;
    return Container(
      padding: margin ?? EdgeInsets.all(AppDimensions.padding),
      margin: isSafeArea ? const EdgeInsets.only(bottom: 16) : EdgeInsets.zero,
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: ElevatedButton(
          onPressed: () {
            if (isEnable == false) {
              return;
            }
            if (isLoading) {
              return;
            }
            if (isCheckLastPress == false) {
              onPressed!();
              return;
            }

            if (onPressed != null) {
              if (_lastOnPressTime != null &&
                  DateTime.now().difference(_lastOnPressTime!).inSeconds < 1) {
                return;
              }
              _lastOnPressTime = DateTime.now();
              onPressed!();
            }
          },
          style: ElevatedButton.styleFrom(
            // overlayColor: AppColors.color8E8,
            elevation: 0,
            backgroundColor: Get.isDarkMode ? colorEnableDarkMode : colorEnable,
            padding: padding ?? EdgeInsets.all(AppDimensions.padding),
            shape: RoundedRectangleBorder(
              side: borderSide ?? BorderSide.none,
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          child: Builder(builder: (context) {
            if (isLoading) {
              return CupertinoActivityIndicator(
                radius: 12,
                color: textColor ?? Colors.white,
              );
            }
            return Text(text,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: textColor ?? Colors.white,
                    fontWeight: FontWeight.w600));
          }),
        ),
      ),
    );
  }
}
