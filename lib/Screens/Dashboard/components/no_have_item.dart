import 'package:flutter/material.dart';

class No_Have_Item extends StatelessWidget {
  const No_Have_Item({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/images/not_data.png",
        width: 300,
        height: 300,
      ),
    );
  }
}
