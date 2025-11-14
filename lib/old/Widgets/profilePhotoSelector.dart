import 'dart:io';

import 'package:flutter/material.dart';

class ProfilePictureSetup extends StatefulWidget {
  const ProfilePictureSetup({super.key});

  @override
  State<ProfilePictureSetup> createState() => _ProfilePictureSetupState();
}

class _ProfilePictureSetupState extends State<ProfilePictureSetup> {
  final List<String> avatarAssets = [
    'assets/onboarding/avatar_1.png',
    'assets/onboarding/avatar_2.png',
    'assets/onboarding/avatar_3.png',
    'assets/onboarding/avatar_4.png',
    'assets/onboarding/avatar_5.png',
  ];

  int selectedAvatar = 0;

  // Dummy "picked" image path (for demonstration, implement image picking as needed)
  String? pickedImagePath;

  final TextEditingController _factController = TextEditingController();

  @override
  void dispose() {
    _factController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final avatarCircle = Center(
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        // clipBehavior: Clip.antiAlias,
        child: Center(
          child: pickedImagePath != null
              ? Image.file(File(pickedImagePath!), fit: BoxFit.cover)
              : Image.asset(avatarAssets[selectedAvatar], fit: BoxFit.fitWidth),
        ),
      ),
    );

    final avatarSelector = Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(avatarAssets.length, (i) {
            final selected = i == selectedAvatar;
            return Padding(
              padding: EdgeInsets.only(
                right: i == avatarAssets.length - 1 ? 0 : 8,
              ),
              child: GestureDetector(
                onTap: () => setState(() => selectedAvatar = i),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 180),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selected ? Color(0xFFFFB9FF) : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: Image.asset(avatarAssets[i], scale: 4),
                ),
              ),
            );
          }),
        ),
      ),

      // Scrollable ListView when it doesn't fit
    );

    final nameText = Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 4),
      child: Text(
        "Sakshi Thombre",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: "Rethink Sans",
        ),
      ),
    );

    final factField = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 69),
      child: TextFormField(
        controller: _factController,
        decoration: InputDecoration(
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF8793A1), width: 1.4),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF8793A1), width: 1.3),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF8793A1), width: 1.7),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0),
          hintText: "Tell us a fun fact about yourself",

          hintStyle: TextStyle(
            color: Color(0xFF8793A1),
            fontSize: 10,
            fontWeight: FontWeight.w600,
            fontFamily: "Rethink Sans",
          ),
        ),
        style: TextStyle(
          color: Color(0xFF8793A1),
          fontSize: 10,
          fontWeight: FontWeight.w600,
          fontFamily: "Rethink Sans",
        ),
        cursorColor: Colors.black,
      ),
    );

    final buttonStyle = OutlinedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      backgroundColor: Color(0xFFFDEAFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(color: Color(0xFFFFB9FF), width: 3),
      ),
      textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        fontFamily: "Rethink Sans",
        color: Color(0xFF1E1E1E),
      ),
    );

    final selectButtons = Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlinedButton.icon(
            onPressed: () {
              // Implement select from device logic!
            },
            icon: Image.asset("assets/onboarding/gallery.png", scale: 4),
            label: Text(
              "Select from device",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                fontFamily: "Rethink Sans",
                color: Color(0xFF1E1E1E),
              ),
            ),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Color(0x4DFFB9FF)),
              side: WidgetStateProperty.all(
                BorderSide(color: Color(0xFFFFB9FF), width: 1.5),
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              textStyle: WidgetStateProperty.all(
                TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                  color: Colors.pink.shade500,
                ),
              ),
              foregroundColor: WidgetStateProperty.all(
                Colors.pink.shade500,
              ), // for text and icon
            ),
          ),
          OutlinedButton.icon(
            onPressed: () {
              // Implement take photo logic!
            },
            icon: Image.asset("assets/onboarding/camera.png", scale: 4),
            label: Text(
              "Take photo",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                fontFamily: "Rethink Sans",
                color: Color(0xFF1E1E1E),
              ),
            ),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Color(0x4DFFB9FF)),
              side: WidgetStateProperty.all(
                BorderSide(color: Color(0xFFFFB9FF), width: 1.5),
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              textStyle: WidgetStateProperty.all(
                TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                  color: Colors.pink.shade500,
                ),
              ),
              foregroundColor: WidgetStateProperty.all(
                Colors.pink.shade500,
              ), // for text and icon
            ),
          ),
        ],
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        Text(
          'Add your profile picture so\npeople can find you',
          textAlign: TextAlign.center,

          style: TextStyle(
            fontSize: 16,
            fontFamily: "Rethink Sans",
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5),
        avatarCircle,
        SizedBox(height: 4),
        // SizedBox(height: 22),
        Align(alignment: Alignment.center, child: avatarSelector),
        nameText,
        factField,
        selectButtons,
        SizedBox(height: 0),
      ],
    );
  }
}
