import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:medicross_admin/Service/database_service.dart';
import '../../Constant/colors.dart';
import '../../Constant/images.dart';
import '../../Model/screen_size.dart';
import '../../Widget/custom_text.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        AdminWelcome(),
        CoverImage(),
        DashboardCard(
          title: "Doctors",
          tilecolor: primaryColor,
        ),
        DashboardCard(
          title: "Patients",
          tilecolor: primaryColor,
        ),
        DashboardCard(
          title: "Appointments",
          tilecolor: primaryColor,
        ),
      ],
    );
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Card(
        child: SizedBox(
          height: ScreenSize.height * 0.2,
          width: ScreenSize.width,
          child: Image.asset(
            admin,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;

  final Color tilecolor;
  const DashboardCard({Key? key, required this.title, required this.tilecolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Card(
        color: tilecolor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 3,
        child: SizedBox(
          width: ScreenSize.width,
          height: ScreenSize.height * 0.14,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: title,
                  color: kwhite,
                  fontSize: 25,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: DatabaseService.getItems(title.toLowerCase(), null),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: kwhite,
                        ),
                      );
                    }

                    return Countup(
                      begin: 0,
                      end: snapshot.data?.docs.length.toDouble() ?? 0,
                      duration: const Duration(seconds: 2),
                      separator: ',',
                      style: const TextStyle(
                        color: kwhite,
                        fontSize: 25,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AdminWelcome extends StatelessWidget {
  const AdminWelcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenSize.height * 0.02),
      child: const ListTile(
        tileColor: kwhite,
        leading: CircleAvatar(
          backgroundImage: AssetImage(logo),
        ),
        title: CustomText(text: "Hello Admin", fontWeight: FontWeight.bold),
        subtitle: CustomText(
            text: "How are you today ?", fontWeight: FontWeight.w500),
        // trailing: IconButton(
        //   onPressed: () {},
        //   icon: const Icon(Icons.notifications),
        // ),
      ),
    );
  }
}
