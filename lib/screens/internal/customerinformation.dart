import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenleaf_insurance/components/constants.dart';
import 'package:greenleaf_insurance/db/database.dart';

import '../../components/bottom_drawer.dart';
import '../../components/buttons.dart';
import '../../components/textentries.dart';
import '../../db/user_db.dart';

class CustomerInformtionScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CustomerInformationState();

}

class _CustomerInformationState extends State<CustomerInformtionScreen>{
  LocalUser _user = LocalUser();
  final TextEditingController _fname = TextEditingController();
  final TextEditingController _lname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _nokName = TextEditingController();
  final TextEditingController _nokEmail = TextEditingController();
  final TextEditingController _nokPhone = TextEditingController();
  final TextEditingController _nokAddress = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser()async {
    LocalUser user = await userProvider.get();
    setState(() {
      _user = user;
      _fname.text = user.firstname;
      _lname.text = user.lastname;
      _email.text = user.email;
      _phone.text = user.phone;
      _address.text = user.houseAddress;
      _nokAddress.text = user.nokAddress;
      _nokEmail.text = user.nokEmail;
      _nokName.text = user.nokName;
      _nokPhone.text = user.nokPhone;
    });
  }
  @override
  Widget build(BuildContext context) {

    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: lightOffWhite,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kPageDefaultPadding),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Customer Info', style: kBlackPageTitleStyle,)
                  ],
                ),
                SizedBox(height: kComponentDefaultSpacing,),
                Text('Hi, Kindly update your information in order to enjoy our services',style: kBasicTextStyle,textAlign: TextAlign.left,),
                SizedBox(height: kPageDefaultPadding,),
                Row(
                  children: [
                    Text('First name', style: kBasicTextStyle,),
                  ],
                ),
                BasicTextEntryBox(hintText: 'Enter your first name',controller: _fname,
                  icon: Icons.person_outlined,textChange: (v)=>_user.firstname=v,),
                SizedBox(height: kComponentDefaultSpacing,),
                Row(
                  children: [
                    Text('Last name', style: kBasicTextStyle,),
                  ],
                ),
                BasicTextEntryBox(hintText: 'Enter your last name',controller: _lname,
                  icon: Icons.person_outlined,textChange: (v)=>_user.lastname=v,),
                SizedBox(height: kComponentDefaultSpacing,),
                Row(
                  children: [
                    Text('Phone Number', style: kBasicTextStyle,),
                  ],
                ),
                BasicTextEntryBox(hintText: 'Enter your phone',controller: _phone,inputType: TextInputType.phone,
                  icon: Icons.phone_outlined,textChange: (v)=>_user.phone=v,),
                SizedBox(height: kComponentDefaultSpacing,),
                Row(
                  children: [
                    Text('Email Address', style: kBasicTextStyle,),
                  ],
                ),
                BasicTextEntryBox(hintText: 'Enter your email',controller: _email,inputType: TextInputType.emailAddress,
                  icon: Icons.email_outlined,textChange: (v)=>_user.email=v,),
                SizedBox(height: kComponentDefaultSpacing,),
                Row(
                  children: [
                    Text('Address', style: kBasicTextStyle,),
                  ],
                ),
                BasicTextEntryBox(hintText: 'Enter your current address',controller: _address,
                  icon: Icons.house,textChange: (v)=>_user.houseAddress=v,),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/rectangle_left.png', scale: 1,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: kComponentDefaultSpacing),
                          child: Text('Next of Kin'),
                        ),
                        Image.asset('assets/images/rectangle_right.png', scale: 1,),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text('Full name', style: kBasicTextStyle,),
                  ],
                ),
                BasicTextEntryBox(hintText: 'Enter NOK Fullname',controller: _nokName,
                  icon: Icons.person_outlined,textChange: (v)=>_user.nokName=v,),
                SizedBox(height: kComponentDefaultSpacing,),
                Row(
                  children: [
                    Text('Phone Number', style: kBasicTextStyle,),
                  ],
                ),
                BasicTextEntryBox(hintText: 'Enter NOK phone',controller: _nokPhone,inputType: TextInputType.phone,
                  icon: Icons.phone_outlined,textChange: (v)=>_user.nokPhone=v,),
                SizedBox(height: kComponentDefaultSpacing,),
                Row(
                  children: [
                    Text('Email Address', style: kBasicTextStyle,),
                  ],
                ),
                BasicTextEntryBox(hintText: 'Enter NOK email',controller: _nokEmail,inputType: TextInputType.emailAddress,
                  icon: Icons.email_outlined,textChange: (v)=>_user.nokEmail=v,),
                SizedBox(height: kComponentDefaultSpacing,),
                Row(
                  children: [
                    Text('Address', style: kBasicTextStyle,),
                  ],
                ),
                BasicTextEntryBox(hintText: 'Enter NOK address',controller: _nokAddress,
                  icon: Icons.house,textChange: (v)=>_user.nokAddress=v,),
                SizedBox(height: kComponentDefaultSpacing,),
                BasicButton(
                  onPress: ()async {
                    await userProvider.save(_user);
                    showModalBottomSheet(context: context,
                        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
                        elevation: 30,
                        isDismissible: false,
                        isScrollControlled: true,
                        builder: (context) =>   ModifiableBottomDrawer(message: 'Your information has been saved',icon: Icons.check_circle,color: kPrimaryColorDark,
                          buttonFunction: (() {
                            Navigator.pop(context);
                          }),
                          buttonText: 'Close',));
                  },
                  text: 'Save',width: _size.width*0.9,),
              ],
            ),
          ),
        ),
      ),
    );
  }

}