import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_manajemen_waktu/constants.dart';
import 'package:image_picker/image_picker.dart';

const defaultAvatar = "assets/images/add_photo.png";

class ProfileAvatar extends StatefulWidget {
  final String profileImage;

  const ProfileAvatar({
    super.key,
    this.profileImage = defaultAvatar,
  });

  @override
  State<StatefulWidget> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  Uint8List? _image;
  File? selectedImage;

  String get profileImage {
    return widget.profileImage;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: _image != null
                ? CircleAvatar(
                    radius: 100,
                    backgroundImage: MemoryImage(_image!),
                  )
                : CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage(
                      profileImage,
                    ),
                  ),
          ),
          Row(
            children: [
              const Spacer(),
              Expanded(
                flex: 2,
                child: buttonPhotoProfile(),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buttonPhotoProfile() {
    return ElevatedButton(
      onPressed: () => {showMoreOptions(context)},
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith(
          (states) => kButtonPrimaryColor,
        ),
        padding: MaterialStateProperty.resolveWith(
          (states) => const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
        ),
      ),
      child: const Text(
        "Choose your photo",
        style: TextStyle(
          color: kButtonSecondaryColor,
        ),
      ),
    );
  }

  void showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Wrap(
          children: <Widget>[
            ListTile(
              onTap: () {
                _pickImage(context);
              },
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from gallery'),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a photo'),
              onTap: () {
                _pickCamera(context);
              },
            ),
          ],
        );
      },
    );
  }

  // Image Picker
  Future _pickImage(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    setState(() {
      selectedImage = File(pickedFile.path);
      _image = File(pickedFile.path).readAsBytesSync();
    });

    Navigator.of(context).pop();
  }

  // Camera Picker
  Future _pickCamera(BuildContext context) async {
    final pickedCamera =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedCamera == null) return;

    setState(() {
      selectedImage = File(pickedCamera.path);
      _image = File(pickedCamera.path).readAsBytesSync();
    });

    Navigator.of(context).pop();
  }
}
