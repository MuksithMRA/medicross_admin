import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicross_admin/Animation/straggered_list.dart';
import 'package:medicross_admin/Model/patient.dart';
import 'package:provider/provider.dart';
import '../Provider/input_provider.dart';
import '../Service/database_service.dart';
import '../Widget/Manage Patients/patient_card.dart';
import '../Widget/custom_text.dart';
import '../Widget/search.dart';

class ManagePatients extends StatelessWidget {
  const ManagePatients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SearchArea(
            type: "Patients",
          ),
          StreamBuilder<QuerySnapshot>(
            stream: DatabaseService.getItems(
                "patients",
                Provider.of<InputProvider>(context, listen: true)
                    .patientSearchText),
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
                  var patient = snapshot.data?.docs[index];
                  return CustomStaggeredList(
                    index: index,
                    child: PatientCard(
                      patient: Patient(
                        profilePic: patient?.get('profilePic'),
                          email: patient?.get('email'),
                          city: patient?.get('city'),
                          fullName: patient?.get('fullName'),
                          phone: patient?.get('phone'),
                          uid: patient?.get('uid'),
                          ref: patient?.reference.id ?? ''),
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
