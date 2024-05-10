import 'package:flutter/material.dart';
import 'package:flutter_manajemen_waktu/constants.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pushNamed(context, '/dashboard'),
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back, size: 30),
      style: ButtonStyle(
        iconColor: MaterialStateProperty.resolveWith<Color?>(
          (states) => kBgSecondaryColor,
        ),
      ),
    );
  }
}
