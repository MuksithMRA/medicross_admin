import 'package:flutter/material.dart';
import 'package:medicross_admin/Provider/input_provider.dart';
import 'package:provider/provider.dart';
import '../../Model/screen_size.dart';
import 'custom_textfield.dart';

class SearchArea extends StatelessWidget {
  final String type;
  const SearchArea({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.03),
      child: SizedBox(
        width: ScreenSize.width * 0.9,
        height: ScreenSize.height * 0.08,
        child: CustomTextField(
          isUnderlineField: true,
          onChanged: (String? val) {
            if (type == "Doctors") {
              Provider.of<InputProvider>(context, listen: false)
                  .setDoctorSearchText(val);
            } else {
              Provider.of<InputProvider>(context, listen: false)
                  .setPatientSearchText(val);
            }
          },
          prefixIcon: Icons.search,
          hintText: "Search $type",
        ),
      ),
    );
  }
}
