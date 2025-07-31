import 'package:amadapp/amad_app.dart';
import 'package:amadapp/common/routing/app_router.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // setUpGetIt();
  runApp(AmadApp(appRouter: AppRouter()));
}
