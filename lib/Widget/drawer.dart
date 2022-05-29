import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicross_admin/Provider/admin_controller.dart';
import 'package:medicross_admin/Provider/error_provider.dart';
import 'package:medicross_admin/Screen/login.dart';
import 'package:medicross_admin/Service/auth.dart';
import 'package:medicross_admin/Widget/snack_bar.dart';
import 'package:provider/provider.dart';

import '../Constant/images.dart';
import '../Model/drawer_tile.dart';
import '../Screen/admin_home.dart';
import 'custom_text.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          drawerHeader(),
          const DrawerTileList(),
        ],
      ),
    );
  }
}

Widget drawerHeader() {
  User user = FirebaseAuth.instance.currentUser!;
  return UserAccountsDrawerHeader(
    currentAccountPicture: const CircleAvatar(
      backgroundImage: AssetImage(logo),
    ),
    accountName: CustomText(
      text: user.displayName.toString(),
      fontSize: 17,
    ),
    accountEmail: CustomText(
      text: user.email.toString(),
      fontSize: 15,
    ),
  );
}

class DrawerTileList extends StatelessWidget {
  const DrawerTileList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adminController = Provider.of<AdminController>(context, listen: true);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: adminController.drawerTileData.length,
      itemBuilder: (BuildContext context, int index) {
        final DrawerTile item = adminController.drawerTileData[index];
        return ListTile(
          onTap: () async {
            if (index != 5) {
              if (index != 4) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) {
                  return AdminHome(index: index);
                }));
              } else {
                String? result = await AuthService().signOut();

                if (result == null) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) {
                    return const Login();
                  }));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                      ErrorProvider.message, Icons.warning, Colors.red));
                }
              }
            } else {
              item.ontap!();
            }
          },
          leading: Icon(item.icon),
          title: CustomText(text: item.title),
        );
      },
    );
  }
}
