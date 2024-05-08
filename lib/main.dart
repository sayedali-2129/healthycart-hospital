import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthycart/app.dart';
import 'package:healthycart/core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependancy();
  runApp(const MyApp());
}
