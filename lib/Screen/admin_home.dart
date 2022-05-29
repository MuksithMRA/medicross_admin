import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Constant/colors.dart';
import '../../Widget/custom_text.dart';
import '../Provider/admin_controller.dart';
import '../Widget/drawer.dart';


class AdminHome extends StatelessWidget {
  final int index;
  const AdminHome({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminController>(
      builder: (context, adminCtrl, child) {
        return Scaffold(
          //floatingActionButton: floatingAction(index),
          extendBody: true,
          appBar: customAppBar(adminCtrl.screenList[index].appbarTitle),
          drawer: const AdminDrawer(),
          body: adminCtrl.screenList[index].bodyWidget,
        );
      },
    );
  }
}

Widget? floatingAction(int index) {
  if (index ==1 || index == 2) {
    return FloatingActionButton.extended(
      onPressed: () {},
      label: const CustomText(text: "Add"),
      icon: const Icon(Icons.add),
    );
  }
  return null;
}

PreferredSize customAppBar(String title) {
  return PreferredSize(
    child: AppBar(
      elevation: 0,
      backgroundColor: primaryColor,
      centerTitle: true,
      title: CustomText(text: title),
    ),
    preferredSize: const Size.fromHeight(60),
  );
}


