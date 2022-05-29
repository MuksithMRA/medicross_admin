import 'package:medicross_admin/Provider/input_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'admin_controller.dart';
import 'login_ controller.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<LoginController>(
    create: (context) => LoginController(),
  ),
  ChangeNotifierProvider<AdminController>(
    create: (context) => AdminController(),
  ),
  ChangeNotifierProvider<InputProvider>(
    create: (context) => InputProvider(),
  ),
];
