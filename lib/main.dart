import 'package:arkademi_test/commons/config/my_app.dart';
import 'package:arkademi_test/commons/config/service_locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  setupLocator();
  runApp(const MyApp());
}
