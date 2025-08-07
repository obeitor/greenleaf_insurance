import 'package:flutter/material.dart';
import 'package:greenleaf_insurance/screens/intro/onboarding.dart';
import 'package:greenleaf_insurance/screens/intro/signupscreen.dart';

import 'db/database.dart';

void main() async{
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await dbProvider.open();
  } catch (e) {
    print(e.toString());
  }
  runApp(const GreenLeafApp());
}

class GreenLeafApp extends StatelessWidget{
  const GreenLeafApp({super.key});


  Future<String> getInitPage()async{
    await Future.delayed(Duration(seconds: 3));
    return "test";
    //return StartPage.SIGNUP;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Inter'
      ),
      title: 'Greenleaf',
      home: FutureBuilder(
        future: getInitPage(),
        builder: (buildContext, snapshot){
          if(snapshot.connectionState != ConnectionState.done || !snapshot.hasData){
            return const LogoScreen();
          }
          else if(snapshot.hasData){
            return  WelcomeScreen();
          }
          return const LogoScreen();
        },
      ),
    );
  }
}
