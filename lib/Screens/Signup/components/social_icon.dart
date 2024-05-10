import 'package:flutter/material.dart';
import 'package:flutter_manajemen_waktu/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocalIcon extends StatelessWidget {
  final String? iconSvg;
  final void Function()? press;

  const SocalIcon({
    super.key,
    this.iconSvg,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: kPrimaryLightColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconSvg!,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
