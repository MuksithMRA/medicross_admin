import 'package:flutter/material.dart';
import 'package:medicross_admin/Provider/error_provider.dart';
import 'package:medicross_admin/Screen/admin_home.dart';
import 'package:medicross_admin/Service/auth.dart';
import 'package:medicross_admin/Widget/loading_dialog.dart';
import 'package:medicross_admin/Widget/snack_bar.dart';
import 'package:provider/provider.dart';

import '../Model/screen_size.dart';
import '../Provider/login_ controller.dart';
import 'custom_button.dart';

class LoginBtn extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const LoginBtn({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
      builder: (context, loginCtrl, child) {
        return CustomButton(
          ontap: () async {
            if (formKey.currentState!.validate()) {
              showLoaderDialog(context);
              String? result = await AuthService().signInWithEmailAndPassword(
                  loginCtrl.email.toString(), loginCtrl.password.toString());
              Navigator.pop(context);
              if (result != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return const AdminHome(index: 0);
                    },
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                    ErrorProvider.message, Icons.warning, Colors.red));
              }
            }
          },
          text: "Log in",
          width: ScreenSize.width,
        );
      },
    );
  }
}
