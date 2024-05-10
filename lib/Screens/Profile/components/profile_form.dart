import 'package:flutter/material.dart';
import 'package:flutter_manajemen_waktu/Screens/Profile/components/profile.dart';
import 'package:flutter_manajemen_waktu/Screens/Profile/components/profile_createTextField.dart';
import 'package:flutter_manajemen_waktu/constants.dart';

class ProfileForm extends StatefulWidget {
  ProfileBuilder profile;

  final Function(String name) setName;
  final Function(String nim) setNim;
  final Function(String kelas) setKelas;
  final Function(String fakultas) setFakultas;

  ProfileForm({
    super.key,
    required this.profile,
    required this.setName,
    required this.setNim,
    required this.setKelas,
    required this.setFakultas,
  });

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  TextEditingController name = TextEditingController();
  TextEditingController nim = TextEditingController();
  TextEditingController kelas = TextEditingController();
  TextEditingController fakultas = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProfileBuilder profile = widget.profile;

    return Column(
      children: [
        const SizedBox(height: defaultPadding * 5),
        BuildFieldText(
          labelText: "Name",
          placeholder: profile.name,
          keyboardType: TextInputType.name,
          prefix: const Icon(
            Icons.person,
            color: kPrimaryColor,
          ),
          controller: name,
          setMethod: widget.setName,
        ),
        BuildFieldText(
          labelText: "NIM",
          placeholder: profile.nim,
          keyboardType: TextInputType.number,
          prefix: const Icon(
            Icons.numbers_rounded,
            color: kPrimaryColor,
          ),
          controller: nim,
          setMethod: widget.setNim,
        ),
        BuildFieldText(
          labelText: "Kelas",
          placeholder: profile.kelas,
          keyboardType: TextInputType.text,
          prefix: const Icon(
            Icons.class_rounded,
            color: kPrimaryColor,
          ),
          controller: kelas,
          setMethod: widget.setKelas,
        ),
        BuildFieldText(
          labelText: "Fakultas",
          placeholder: profile.fakultas,
          keyboardType: TextInputType.text,
          prefix: const Icon(
            Icons.school_rounded,
            color: kPrimaryColor,
          ),
          controller: fakultas,
          setMethod: widget.setFakultas,
        ),
      ],
    );
  }
}
