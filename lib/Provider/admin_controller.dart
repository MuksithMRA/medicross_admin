import 'dart:io';
import 'package:flutter/material.dart';
import '../Model/admin_screen.dart';
import '../Model/drawer_tile.dart';
import '../Screen/admin_profile.dart';
import '../Screen/dashboard.dart';
import '../Screen/manage_doctors.dart';
import '../Screen/manage_patient.dart';

class AdminController extends ChangeNotifier {
  List<DrawerTile> drawerTileData = [
    DrawerTile(icon: Icons.home, title: "Dashboard"),
    DrawerTile(icon: Icons.group, title: "Manage Doctors"),
    DrawerTile(icon: Icons.group, title: "Manage Patients"),
    DrawerTile(icon: Icons.person, title: "My Profile"),
    DrawerTile(
      icon: Icons.logout,
      title: "Log out",
    ),
    DrawerTile(
      icon: Icons.exit_to_app,
      title: "Exit",
      ontap: () {
        exit(0);
      },
    ),
  ];

  List<AdminScreenModel> screenList = [
    AdminScreenModel(
        appbarTitle: "Dashboard", bodyWidget: const DashBoardScreen()),
    AdminScreenModel(
        appbarTitle: "Manage Doctors", bodyWidget: const ManageDoctors()),
    AdminScreenModel(
        appbarTitle: "Manage Patients", bodyWidget: const ManagePatients()),
    AdminScreenModel(
        appbarTitle: "My Profile", bodyWidget: const AdminProfile()),
  ];
}
