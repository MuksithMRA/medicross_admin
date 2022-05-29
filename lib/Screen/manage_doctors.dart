import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicross_admin/Animation/straggered_list.dart';
import 'package:medicross_admin/Provider/input_provider.dart';
import 'package:provider/provider.dart';
import '../Model/doctor.dart';
import '../Service/database_service.dart';
import '../Widget/Manage Doctors/doctor_card.dart';
import '../Widget/custom_text.dart';
import '../Widget/search.dart';

class ManageDoctors extends StatelessWidget {
  const ManageDoctors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SearchArea(
            type: "Doctors",
          ),
          StreamBuilder<QuerySnapshot>(
            stream: DatabaseService.getItems(
                "doctors",
                Provider.of<InputProvider>(context, listen: true)
                    .doctorSearchText),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                debugPrint("${snapshot.error}");
                return const Center(
                  child: CustomText(text: "Something went wrong"),
                );
              }
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  var doctor = snapshot.data?.docs[index];
                  return CustomStaggeredList(
                    index: index,
                    child: DoctorCard(
                      doctor: Doctor(
                        profilePic : doctor?.get("profilePic"),
                        ref: doctor?.reference.id,
                        name: doctor?.get("fullName"),
                        specialization: doctor?.get("specialization"),
                        city: doctor?.get("city"),
                        reviewCount: doctor?.get("reviewCount"),
                        ratingCount: double.parse(doctor?.get("ratingCount")),
                        isAvailable: doctor?.get("availability"),
                        email: doctor?.get("email"),
                        phone: doctor?.get("phone"),
                        uid: snapshot.data?.docs[index].reference.id ?? '',
                        hourlyRate: double.parse(doctor?.get("hourly_rate")),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
