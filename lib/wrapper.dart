import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Model/screen_size.dart';
import 'Provider/login_ controller.dart';
import 'Screen/admin_home.dart';
import 'Screen/login.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    ScreenSize.setScreenSize(h: screenSize.height, w: screenSize.width);

    return Consumer<LoginController>(
      builder: (context, loginCtrl, child) {
        loginCtrl.setLoginState();

        if (loginCtrl.isLoggedIn) {
          return const AdminHome(index: 0);
        } else {
          return const Login();
        }
      },
    );
  }
}
