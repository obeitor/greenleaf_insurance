//colors
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Colors
const kPrimaryColor = Color(0xFF226B3D);
const kPrimaryColorLight = Color(0xFF3DBD6C);
const kPrimaryColorDark = Color(0xFF0F2F1B);
const kAccentColor = Color(0xFF7523B6);
const kSecondaryColor = Color(0xFFB62364);
const kTertiaryColor = Color(0xFF2364B6);
const kFourthColor = Color(0xFFDEB83C);
const hintColor = Color.fromRGBO(138, 137, 137, 0.7);
const lightOffWhite = Color.fromRGBO(245, 245, 245, 1);
const kLightGrey = Color(0xFFDCDBDB);
const kPrimaryGradient = LinearGradient(
  colors: [kPrimaryColor, kPrimaryColorLight, Color(0xFFD4E5C6), kPrimaryColorLight, kPrimaryColor],
  stops: [0.0, 0.4,0.5,0.6, 1.0], // Adjust stops to control the green dominance
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

//padding size
const kPageDefaultPadding = 20.0;
const kContainerDefaultPadding = 8.0;
const kComponentDefaultSpacing = 10.0;
const kTextSpacingDefaultPadding = 4.0;
const kHomePagePadding = 30.0;
const kPageTitleBottomSpace = 40.0;
const kProfileInitialsPadding = 30.0;
const kTitleAllPadding = 15.0;
const kBottomDrawerHeight = 250.0;
const kLogoIconSmallScale = 10.0;
const kLogoIconMediumScale = 25.0;
const kBottomSheetHeight = 80.0;
const kBannerHeight = 250.0;

//Styles

final kBasicTextStyle =  TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.black87,);
final kLabelTextStyle =  TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87);
final kBoldBasicTextStyle =  TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87);
final kWhiteTextStyle =  TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white);
final kPrimaryDarkTitleStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: kPrimaryColorDark);
final kBlackTitleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87);
final kTertiaryTitleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: kTertiaryColor);
final kWhiteTitleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white);
final kBlackPageTitleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black87);
final kPrimaryTextStyle =  TextStyle(fontWeight: FontWeight.normal, fontSize: 15, color: kPrimaryColor);
const kEntryBoxHintStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black54);
const kEntryBoxTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black, letterSpacing: 2);
const kBoldWhiteProfileTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white, letterSpacing: 2);
const kErrorTextStyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.red);

Container kIconBox(IconData icon, Color color, double size) => Container(
  padding: const EdgeInsets.all(8.0),
  decoration: BoxDecoration(
    color: color,
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
  ),
  child: Icon(icon, color: Colors.black, size: size,),
);

const kDrawerHandle =  Padding(
    padding: EdgeInsets.only( bottom: 50,left: 25,right: 25),
    child: Divider(color: kPrimaryColorDark,endIndent: 50, indent: 50,thickness: 2.5,));

Container logoWithText(double size) => Container(
  padding: const EdgeInsets.all(5),
  decoration: BoxDecoration(
    color: kPrimaryColor,
    borderRadius: BorderRadius.circular(20)
  ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image(
          image: const AssetImage('assets/images/greenleaf_logo.png'),
          height: size,
          width: size,
          fit: BoxFit.contain,
        ),
        SizedBox(width: size/3,),
        Text('Greenleaf',style: TextStyle(color: Colors.white, fontSize: size/2, fontWeight: FontWeight.bold),)
      ],
    ),
);



const nairaSign = "₦";
final moneyFormat =  NumberFormat.currency(locale: 'en_us',name: 'naira',symbol:nairaSign,decimalDigits: 2);