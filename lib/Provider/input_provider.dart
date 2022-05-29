import 'package:flutter/cupertino.dart';

class InputProvider extends ChangeNotifier {
  String? doctorSearchText;
  String? patientSearchText;

  setDoctorSearchText(String? val) {
    doctorSearchText = val;
    notifyListeners();
  }
  setPatientSearchText(String? val) {
    patientSearchText = val;
    notifyListeners();
  }
}
