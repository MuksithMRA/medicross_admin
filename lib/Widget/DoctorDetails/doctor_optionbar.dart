import 'package:flutter/material.dart';
import 'package:medicross_admin/Model/screen_size.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Model/doctor.dart';

class DoctorOptionBar extends StatelessWidget {
  final Doctor doctor;
  const DoctorOptionBar({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () async {
              String url = "tel:${doctor.phone}";
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                throw "Could not launch $url";
              }
            },
            child: const Icon(Icons.call),
          ),
          SizedBox(
            width: ScreenSize.width * 0.1,
          ),
          FloatingActionButton(
            onPressed: () async {
              String url =
                  "mailto:${doctor.email}?subject=<subject>&body=<body>";
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                throw "Could not launch $url";
              }
            },
            child: const Icon(Icons.mail),
          ),
        ],
      ),
    );
  }
}
