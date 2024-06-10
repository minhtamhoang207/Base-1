import 'package:flutter/material.dart';
import 'package:base_1/app.dart';
import 'package:base_1/core/config/env_config.dart';
import 'package:base_1/core/injection/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvConfig.loadEnv();
  configureDependencies();
  runApp(const MyApp());
}
