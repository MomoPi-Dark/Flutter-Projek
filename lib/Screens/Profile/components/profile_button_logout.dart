import 'package:flutter/material.dart';
import 'package:flutter_manajemen_waktu/constants.dart';

class Profile_Button_Logout extends StatelessWidget {
  const Profile_Button_Logout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Expanded(
          flex: 18,
          child: buttonLogout(context),
        ),
        const Spacer(),
      ],
    );
  }

  Widget buttonLogout(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (builder) {
            return AlertDialog(
              title: const Text("Logout"),
              content: const Text("Are you sure you want to logout?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      "/welcome",
                    );
                  },
                  child: const Text("Yes"),
                ),
              ],
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE72929),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding * 2,
          vertical: defaultPadding,
        ),
      ),
      child: const Text("Logout"),
    );
  }
}
