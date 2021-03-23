
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fotodio/Screens/checkScreen.dart';
import 'package:fotodio/Screens/splashScreen.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: checkScreen("+923110995125"),));
}
