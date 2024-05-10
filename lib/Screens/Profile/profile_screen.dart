import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_manajemen_waktu/Screens/Profile/components/profile.dart';
import 'package:flutter_manajemen_waktu/Screens/Profile/components/profile_avatar.dart';
import 'package:flutter_manajemen_waktu/Screens/Profile/components/profile_button_logout.dart';
import 'package:flutter_manajemen_waktu/Screens/Profile/components/profile_form.dart';
import 'package:flutter_manajemen_waktu/components/back.dart';
import 'package:flutter_manajemen_waktu/constants.dart';
import 'package:flutter_manajemen_waktu/layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../responsive.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late SharedPreferences sp;

  ProfileBuilder profile = ProfileBuilder(
    name: "Iqbal",
    nim: "21331",
    kelas: "",
    fakultas: "",
  );

  @override
  void initState() {
    getSharedPrefrences();
    super.initState();
  }

  void resetSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    print("SharedPreferences reset successfully.");
  }

  getSharedPrefrences() async {
    sp = await SharedPreferences.getInstance();
    readFromSp();
  }

  saveIntoSp() {
    sp.setString("profile", jsonEncode(profile.toJson()).toString());
  }

  readFromSp() {
    String? profileString = sp.getString("profile");

    if (profileString != null) {
      setState(() {
        profile = ProfileBuilder.fromJson(jsonDecode(profileString));
      });
    }

    saveIntoSp();
  }

  setName(String name) {
    setState(() {
      profile.name = name;
    });

    saveIntoSp();
  }

  setNim(String nim) {
    setState(() {
      profile.nim = nim;
    });

    saveIntoSp();
  }

  setKelas(String kelas) {
    setState(() {
      profile.kelas = kelas;
    });

    saveIntoSp();
  }

  setFakultas(String fakultas) {
    setState(() {
      profile.fakultas = fakultas;
    });

    saveIntoSp();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutScreen(
      backgroundColor: kBgPrimaryColor,
      leading: const ArrowBack(),
      title: const Text(
        "Edit Profile",
        style: TextStyle(
          fontSize: 23,
          color: titleColor,
          fontFamily: "SF Pro Display",
          fontWeight: FontWeight.bold,
        ),
      ),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Responsive(
            mobile: MobileProfileScreen(
              profile: profile,
              setFakultas: setFakultas,
              setKelas: setKelas,
              setName: setName,
              setNim: setNim,
            ),
            desktop: DesktopProfileScreen(
              profile: profile,
              setFakultas: setFakultas,
              setKelas: setKelas,
              setName: setName,
              setNim: setNim,
            ),
          ),
        ),
      ),
    );
  }
}

class DesktopProfileScreen extends StatelessWidget {
  final ProfileBuilder profile;
  final Function(String name) setName;
  final Function(String nim) setNim;
  final Function(String kelas) setKelas;
  final Function(String fakultas) setFakultas;

  const DesktopProfileScreen({
    super.key,
    required this.profile,
    required this.setName,
    required this.setNim,
    required this.setKelas,
    required this.setFakultas,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          child: ProfileAvatar(),
        ),
        Expanded(
          child: ProfileForm(
            profile: profile,
            setFakultas: setFakultas,
            setKelas: setKelas,
            setName: setName,
            setNim: setNim,
          ),
        ),
        const Spacer(),
        const Expanded(
          child: Profile_Button_Logout(),
        ),
        const Spacer(),
      ],
    );
  }
}

class MobileProfileScreen extends StatelessWidget {
  final ProfileBuilder profile;
  final Function(String name) setName;
  final Function(String nim) setNim;
  final Function(String kelas) setKelas;
  final Function(String fakultas) setFakultas;

  const MobileProfileScreen({
    super.key,
    required this.profile,
    required this.setName,
    required this.setNim,
    required this.setKelas,
    required this.setFakultas,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileAvatar(),
        ProfileForm(
          profile: profile,
          setFakultas: setFakultas,
          setKelas: setKelas,
          setName: setName,
          setNim: setNim,
        ),
        SizedBox(height: defaultPadding + 10),
        Profile_Button_Logout()
      ],
    );
  }
}
