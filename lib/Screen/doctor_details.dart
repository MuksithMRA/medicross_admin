import 'package:flutter/material.dart';
import '../Model/doctor.dart';
import '../Model/screen_size.dart';
import '../Widget/DoctorDetails/details_tiles.dart';
import '../Widget/DoctorDetails/doctor_availability.dart';
import '../Widget/DoctorDetails/doctor_optionbar.dart';
import '../Widget/DoctorDetails/doctor_profilepic.dart';
import '../Widget/custom_text.dart';

class DoctorDetails extends StatelessWidget {
  final Doctor doctor;
  const DoctorDetails({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const CustomText(text: "Doctor"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DoctorProfilePic(
              doctor: doctor,
            ),
            SizedBox(height: ScreenSize.height * 0.03),
            CustomText(
              text: doctor.name,
              fontSize: 25,
            ),
            DoctorAvailability(isAvailable: doctor.isAvailable),
            // const SizedBox(
            //   height: 10,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ratingBar(intialRating: doctor.ratingCount),
            //     CustomText(text: "(${doctor.reviewCount})")
            //   ],
            // ),
            const SizedBox(
              height: 20,
            ),
            DetailsTiles(
              doctor: doctor,
            ),
            DoctorOptionBar(
              doctor: doctor,
            ),
          ],
        ),
      ),
    );
  }
}
