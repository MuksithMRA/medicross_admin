import 'package:flutter/material.dart';
import '../Constant/colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final Color backgroundColor;
  final Color fontColor;
  final double? width;
  final String text;
  final double radius;
  final double height;
  final void Function()? ontap;
  const CustomButton({
    Key? key,
    this.backgroundColor = primaryColor,
    this.radius = 10,
    this.fontColor = Colors.white,
    this.width,
    required this.text,
    this.ontap, this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      elevation: 3,
      borderRadius: BorderRadius.circular(radius),
      child: MaterialButton(
        minWidth: width,
        height: height,
        child: CustomText(
          text: text,
          color: fontColor,
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: ontap,
      ),
    );
  }
}
