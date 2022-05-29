import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Constant/images.dart';
import '../../Model/screen_size.dart';
import '../../Widget/custom_textfield.dart';
import '../Provider/login_ controller.dart';
import '../Provider/validations.dart';
import '../Widget/login_btn.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email;
  String? password;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
      builder: (context, loginCtrl, child) {
        return Scaffold(
            body: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.05),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: ScreenSize.height * 0.1,
                  ),
                  SizedBox(
                    height: ScreenSize.height * 0.3,
                    child: Image.asset(
                      logo,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: ScreenSize.height * 0.035,
                  ),
                  CustomTextField(
                      onChanged: (val) {
                        loginCtrl.emailOnchanged(val);
                      },
                      validator: (val) {
                        return ValidationController.isEmailValidated(val);
                      },
                      prefixIcon: Icons.mail,
                      labelText: "Email"),
                  SizedBox(
                    height: ScreenSize.height * 0.03,
                  ),
                  CustomTextField(
                    isPassword: true,
                      onChanged: (val) {
                        loginCtrl.passwordOnchanged(val);
                      },
                      validator: (val) {
                        return ValidationController.isNewPassValidated(val);
                      },
                      prefixIcon: Icons.lock,
                      labelText: "Password"),
                  SizedBox(
                    height: ScreenSize.height * 0.04,
                  ),
                  LoginBtn(
                    formKey: _formKey,
                  ),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
