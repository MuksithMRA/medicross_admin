import 'package:flutter/material.dart';
import '../../../Constant/colors.dart';
import '../../../Constant/images.dart';
import '../../../Model/screen_size.dart';
import '../../Model/patient.dart';
import '../custom_text.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  const PatientCard({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
          color: kwhite,
          elevation: 3,
          child: SizedBox(
            width: ScreenSize.width,
            child: ListTile(
              leading: Image.network(
               patient.profilePic,
                fit: BoxFit.fill,
              ),
              title: CustomText(text: patient.fullName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: patient.email),
                  SizedBox(
                    height: ScreenSize.height * 0.015,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    const WidgetSpan(
                        child: Icon(
                      Icons.location_city,
                      color: primaryColor,
                    )),
                    TextSpan(
                        style: const TextStyle(color: kBlack),
                        text: " ${patient.city}"),
                  ])),
                  SizedBox(
                    height: ScreenSize.height * 0.02,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
