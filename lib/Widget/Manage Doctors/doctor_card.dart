import 'package:flutter/material.dart';
import '../../Animation/page_transition_slide.dart';
import '../../Constant/colors.dart';
import '../../Constant/images.dart';
import '../../Model/doctor.dart';
import '../../Model/screen_size.dart';
import '../../Screen/doctor_details.dart';
import '../custom_text.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: kwhite,
        borderRadius: BorderRadius.circular(20),
        elevation: 3,
        child: SizedBox(
          width: ScreenSize.width,
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  SlideTransition1(DoctorDetails(
                    doctor: doctor,
                  )));
            },
            leading: Image.network(
              doctor.profilePic,
              fit: BoxFit.cover,
            ),
            title: CustomText(text: doctor.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Specialized In ${doctor.specialization}"),
                RichText(
                    text: TextSpan(children: [
                  const WidgetSpan(
                      child: Icon(
                    Icons.location_city,
                    color: primaryColor,
                  )),
                  TextSpan(
                      style: const TextStyle(color: kBlack), text: doctor.city),
                ])),
                SizedBox(
                  height: ScreenSize.height * 0.02,
                ),
                // CustomText(text: "${doctor.reviewCount} reviews"),
                // SizedBox(
                //   height: ScreenSize.height * 0.008,
                // ),
                // RatingBar.builder(
                //   ignoreGestures: true,
                //   itemSize: 17,
                //   initialRating: doctor.ratingCount,
                //   minRating: 1,
                //   direction: Axis.horizontal,
                //   allowHalfRating: true,
                //   itemCount: 5,
                //   itemPadding: const EdgeInsets.only(right: 4.0),
                //   itemBuilder: (context, _) => const Icon(
                //     Icons.star,
                //     color: Colors.amber,
                //   ),
                //   onRatingUpdate: (rating) {},
                // )
              ],
            ),
            trailing: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        doctor.isAvailable
                            ? Icons.event_available
                            : Icons.event_busy,
                        color: doctor.isAvailable ? primaryColor : Colors.red,
                      ),
                      CustomText(
                        text: doctor.isAvailable ? "Available" : "Busy",
                        color: doctor.isAvailable ? primaryColor : Colors.red,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
