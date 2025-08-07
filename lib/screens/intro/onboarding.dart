import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenleaf_insurance/components/buttons.dart';
import 'package:greenleaf_insurance/screens/intro/loginscreen.dart';
import 'package:greenleaf_insurance/screens/intro/signupscreen.dart';

import '../../components/constants.dart';

class LogoScreen extends StatelessWidget{
  const LogoScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Container(
              padding: EdgeInsets.all(0),
              child: Column(
                children: [
                  Container(
                      child:  logoWithText(60)
                  ),
                  const Text('INSURANCE BROKERS',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500, fontSize: 16),),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: const Column(
                children: [
                  Text('RC1711156', style: TextStyle(color: Colors.white, fontSize: 13)),
                  Text("Licensed by the National Insurance Commission", style: TextStyle(color: Colors.white, fontSize: 12),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}


class WelcomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _WelcomeState();

}

class _WelcomeState extends State<WelcomeScreen>{

  final List<String> _banners = ['banner_1','banner_2','banner_3'];
  final List<Widget> _titles = [
    RichText(text: TextSpan(
        style: TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
        children: [
          TextSpan(text: 'Protect What Matters\nwith'),
          TextSpan(text: ' Greenleaf', style: TextStyle(color: Colors.black54)),
          TextSpan(text: '!')
        ]
    )),
    Text('Curated Insurance \nProducts!',style: TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold)),
    Text('Simplified Claims to get\nyou back on Track',style: TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold)),
  ];

  final List<String> _subtitles = ['Smart insurance solutions tailored to your needs.\nGet started today!',
    "We handpick the right insurance plans so you \ndon't have to worry",
    "Easily file and track claims -- we are here to guide \nand support you every step of the way"
  ];
  int _position = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset(
            'assets/images/${_banners[_position]}.png',
            fit: BoxFit.fill,
          )),
          Positioned.fill(child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  kPrimaryColor.withOpacity(0.7),
                  kPrimaryColor,
                ],
                stops: [0.0,0.4,0.8]
              )
            ),
          )),
          Positioned.fill(child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      logoWithText(25),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                    child: SizedBox()),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              _titles[_position],
                            ],
                          ),
                          Row(
                            children: [
                              Text(_subtitles[_position], style: TextStyle(color: Colors.white, fontSize: 15),)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 3,
                                  child: SizedBox()),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: BasicButton(text: _position==2?'Get Started':'Continue',
                                    bgColor: Colors.white,textColor: kPrimaryColor,
                                    borderColor: kPrimaryColor, onPress: _changePosition,),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ))
        ],
      ),
    );
  }

  _changePosition() {
    if(_position>=2){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StartScreen()));
    }
    else{
      setState(() {
        _position++;
      });
    }
  }

}

class StartScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _StartState();
}

class _StartState extends State<StartScreen>{
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset(
            'assets/images/banner_4.png',
            fit: BoxFit.fill,
          )),
          Positioned.fill(child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      kPrimaryColor.withOpacity(0.7),
                      kPrimaryColor,
                    ],
                    stops: [0.0,0.4,0.8]
                )
            ),
          )),
          Positioned.fill(child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                            ),
                            child: Column(
                              children: [
                                Image(
                                  image: const AssetImage('assets/images/greenleaf_logo.png'),
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.contain,
                                  color: kPrimaryColor,
                                ),
                                Text('Greenleaf',style: TextStyle(color: kPrimaryColor, fontSize: 30, fontWeight: FontWeight.bold),),
                                Text('INSURANCE BROKERS',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600, fontSize: 14),),
                              ],
                            ),
                          ),
                          Text('Your trusted partner for finding the perfect\ninsurance solutions tailored to your unique\nneeds.',
                            style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
                          BasicButton(text: 'Sign Up', borderColor: kPrimaryColor,onPress: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen())),
                            bgColor: kPrimaryColor,textColor: Colors.white,width: _size.width*0.9,),
                          BasicButton(text: 'Login', borderColor: Colors.white,onPress: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen())),
                            bgColor: Colors.white,textColor: kPrimaryColor,width: _size.width*0.9,),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('RC1711156', style: TextStyle(color: Colors.white, fontSize: 13)),
                          Text("Licensed by the National Insurance Commission", style: TextStyle(color: Colors.white, fontSize: 12),)
                        ],
                      ),
                    ))
              ],
            ),
          ))
        ],
      ),
    );
  }

}
