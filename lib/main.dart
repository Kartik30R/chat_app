import 'package:flutter/material.dart';
import 'package:hashtag/components/message/special_textfield_controller.dart';
import 'package:hashtag/services/auth/auth_gate.dart';
import 'package:hashtag/services/auth/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    child: MyApp(),
    providers: [
      ChangeNotifierProvider(
        create: (context) => AuthService(),
      )
    ],
  ));
}

class MyApp extends StatefulWidget {
   MyApp({super.key});







  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 SpecialTextEditingController _controller=SpecialTextEditingController();
String text='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {setState(() {
      text=_controller.text;
    });});
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: 
      Scaffold(body:  AuthGate(),)
     
    );
  }
}





