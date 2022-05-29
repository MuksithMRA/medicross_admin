import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicross_admin/Provider/validations.dart';
import 'package:medicross_admin/Service/database_service.dart';
import 'package:medicross_admin/Widget/custom_button.dart';
import 'package:medicross_admin/Widget/custom_textfield.dart';

import '../../Constant/colors.dart';
import '../../Constant/images.dart';
import '../../Model/screen_size.dart';
import '../../Widget/custom_text.dart';

class AdminProfile extends StatelessWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        ProfileBg(),
      ],
    );
  }
}

class ProfileBg extends StatelessWidget {
  const ProfileBg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.width,
      height: ScreenSize.height,
      color: primaryColor,
      child: SizedBox(
        width: ScreenSize.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage(logo),
            ),
            const SizedBox(
              height: 10,
            ),
             CustomText(
              text: FirebaseAuth.instance.currentUser?.displayName??"Loading ... ",
              color: kwhite,
              fontSize: 30,
            ),
            const CustomText(
              text: "Master Admin",
              color: kwhite,
              fontSize: 18,
            ),
            SizedBox(
              height: ScreenSize.height * 0.02,
            ),
            CustomButton(
              text: "Edit profile",
              backgroundColor: kwhite,
              fontColor: primaryColor,
              width: ScreenSize.width * 0.3,
              ontap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) {
                    return const EditAdminProfile();
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class EditAdminProfile extends StatefulWidget {
  const EditAdminProfile({Key? key}) : super(key: key);

  @override
  State<EditAdminProfile> createState() => _EditAdminProfileState();
}

class _EditAdminProfileState extends State<EditAdminProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _editName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: const Center(
          child: CustomText(text: "Edit Profile"),
        ),
        content: SizedBox(
          height: ScreenSize.height * 0.2,
          width: ScreenSize.width,
          child: Center(
            child: CustomTextField(
              prefixIcon: Icons.person,
              hintText: 'Enter full name',
              controller: _editName,
              validator: (val) {
                return ValidationController.isFullNameValid(val);
              },
            ),
          ),
        ),
        actions: [
          CustomButton(
            text: "Update",
            ontap: () async {
              if (_formKey.currentState!.validate()) {
                await DatabaseService.updateFullName(_editName.text);
                Navigator.pop(context);
              }
            },
          ),
          CustomButton(
            text: "Close",
            ontap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
