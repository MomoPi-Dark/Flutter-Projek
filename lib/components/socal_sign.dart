import 'package:flutter/material.dart';

import '../../../components/or_divider.dart';
import '../../../Screens/Signup/components/social_icon.dart';

class SocialSign extends StatelessWidget {
  const SocialSign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OrDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SocalIcon(
              iconSvg: "assets/icons/facebook.svg",
              press: () {},
            ),
            SocalIcon(
              iconSvg: "assets/icons/twitter.svg",
              press: () {},
            ),
            SocalIcon(
              iconSvg: "assets/icons/google-plus.svg",
              press: () {},
            ),
          ],
        ),
      ],
    );
  }
}
