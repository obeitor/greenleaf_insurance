import 'package:flutter/material.dart';
import 'package:greenleaf_insurance/screens/intro/signupscreen.dart';

import '../../components/bottom_drawer.dart';
import '../../components/buttons.dart';
import '../../components/constants.dart';
import '../../components/textentries.dart';
import '../../services/userservice.dart';
import '../../utils/exceptionutils.dart';
import '../internal/homescreen.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen>{
  bool _showPassword = false;
  UserService _userService = UserService();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(kPageDefaultPadding),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const Row(
                  children: [
                    Image(
                      image: const AssetImage('assets/images/greenleaf_logo.png'),
                      height: 50,
                      width: 50,
                      fit: BoxFit.contain,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Welcome Back!', style: kBlackPageTitleStyle,)
                  ],
                ),
                const SizedBox(height: kComponentDefaultSpacing,),
                Row(
                  children: [
                    Text('Securely access your insurance dashboard.',style: kBasicTextStyle,textAlign: TextAlign.left,),
                  ],
                ),
            
                SizedBox(height: kPageDefaultPadding,),
                Row(
                  children: [
                    Text('Email',style: kLabelTextStyle,textAlign: TextAlign.left,),
                  ],
                ),
                BasicTextEntryBox(hintText: 'Enter your email',controller: _email,),
                SizedBox(height: kComponentDefaultSpacing,),
                Row(
                  children: [
                    Text('Password',style: kLabelTextStyle,textAlign: TextAlign.left,),
                  ],
                ),
                PasswordTextEntryBox(hintText: 'Enter your password',viewPassword: _showPassword,
                  controller: _password,
                  viewChange: (()=>setState((){
                  _showPassword = !_showPassword;
                })),),
                SizedBox(height: kComponentDefaultSpacing,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(kContainerDefaultPadding),
                        child: Text('Forgot Password?', style: kBasicTextStyle,),
                      ),
                    )
                  ],
                ),
                SizedBox(height: kComponentDefaultSpacing,),
                BasicButton(
                  text: 'Login',width: _size.width*0.9,
                  onPress: (){
                    showLoader('Login in', context, (()async{
                      try{
                        await _userService.login(_email.text,_password.text);
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                      }on ApiException catch(e){
                        Navigator.pop(context);
                        showError(e.getMsg(), context);
                      }
                    }));
                  },
                ),
                Container(
                  padding: EdgeInsets.all(kContainerDefaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? ",style: kEntryBoxHintStyle,),
                      GestureDetector(
                        onTap: ((){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                        }),
                        child: Text('Sign Up', style: TextStyle(fontWeight: FontWeight.w600, decoration: TextDecoration.underline,
                            fontSize: 15, color: kPrimaryColor),),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login()async{
    await Future.delayed(Duration(seconds: 0));
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

}