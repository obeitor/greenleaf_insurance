import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenleaf_insurance/models/usermodels.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../components/buttons.dart';
import '../../components/constants.dart';
import '../../components/nav.dart';
import '../../db/database.dart';
import '../../db/user_db.dart';
import '../../services/userservice.dart';
import '../intro/loginscreen.dart';

class ProfileScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ProfileState();

}

class _ProfileState extends State<ProfileScreen>{

  User _user = User();
  UserService _userService = UserService();
  String _nameAbv = 'NA';
  String _referralCode = '     ';
  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadUser();
  }

  void _loadUser()async {
    User user = await _userService.me();
    setState(() {
      _user = user;
    });
    String code = await _userService.myReferral();
    setState(() {
      _referralCode = code;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(kPageDefaultPadding),
          //child: SingleChildScrollView(
          //  scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TitleBar(showBack: false, title: 'Profile'),
                SizedBox(height: 20.0,),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: Image(
                        image: const AssetImage('assets/images/greenleaf_logo.png'),
                        height: 25,
                        width: 25,
                        fit: BoxFit.contain,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${_user.firstname} ${_user.lastname}',
                                  style: kBoldBasicTextStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(_user.email, style: kBasicTextStyle,)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(onPressed: ((){}), icon: Icon(MdiIcons.leadPencil, color: kPrimaryColor,))
                  ],
                ),
                SizedBox(height: 10.0,),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.2)
                  ),
                  child: Row(
                    children: [
                      Text('Your Unique Identifier Code', style: TextStyle(fontSize: 12, color: kPrimaryColor),),
                      SizedBox(width: 15.0,),
                      for(int i = 0; i<_referralCode.length;i++)
                        Container(
                          padding: EdgeInsets.all(3.0),
                          margin: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            color: kPrimaryColor
                          ),
                          child: Text(_referralCode[i], style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),),
                        )
                    ],
                  ),
                ),
                SizedBox(height: 10.0,),
                Divider(color: hintColor,thickness: 0.5,),
                MenuRow(text: 'Invite Friends',iconData: Icons.share,color: kPrimaryColor,onTap: (){},),
                MenuRow(text: 'Settings',iconData: Icons.settings,color: kPrimaryColor,onTap: (){},),
                MenuRow(text: 'Support',iconData: Icons.question_mark,color: kPrimaryColor,onTap: (){},),
                MenuRow(
                  onTap: ((){
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> LoginScreen()));
                  }),
                  text: 'Logout',iconData: Icons.logout,color: kSecondaryColor,
                ),

              ],
           // ),
          ),
    );
  }
}

class MenuRow extends StatelessWidget {

  MenuRow({required this.iconData, required this.text, required this.onTap,this.color=kPrimaryColor});

  final IconData iconData;
  final String  text;
  final Function onTap;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.0),
      child: GestureDetector(
        onTap: (){
          onTap();
        },
        child: Container(
          padding: const EdgeInsets.all( 15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: .5,
                  offset: Offset(0, .5),
                  blurRadius: 2.8,
                ),
              ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //const SizedBox(height: 15.0,),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: Icon(
                  iconData,
                  color: color,
                  size: 16,
                ),
              ),
              const SizedBox(width: 15.0,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(text, style: TextStyle(color: color, fontSize: 15),),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 17,
                color: Colors.black38,
              ),
            ],
          ),
        ),
      ),
    );
  }
}