import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenleaf_insurance/components/buttons.dart';
import 'package:greenleaf_insurance/models/usermodels.dart';
import 'package:greenleaf_insurance/screens/internal/browsepolicyscreen.dart';
import 'package:greenleaf_insurance/screens/internal/single_insurance.dart';
import 'package:greenleaf_insurance/services/userservice.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../components/bottom_drawer.dart';
import '../../components/constants.dart';

class DashboardScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _DashboardState();

}

class _DashboardState extends State<DashboardScreen>{

  User _user = User();
  UserService _userService = UserService();
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.all(kPageDefaultPadding),
      child:  Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: kPageDefaultPadding),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: Image(
                          image: const AssetImage('assets/images/greenleaf_logo.png'),
                          height: 20,
                          width: 20,
                          fit: BoxFit.contain,
                          color: Colors.white,
                        ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 5,
                    child: Text('\tHello ${_user!.firstname}', style: kBasicTextStyle,)),
                Expanded(
                    flex: 1,
                    child: Center(
                      child: GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.2),
                            border: Border.all(color: hintColor, width: 0.3),
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          ),
                          child: const Icon(Icons.notifications, color: kPrimaryColor, size: 22.0,),
                        ),
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(kPageDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: GestureDetector(
                  onTap: (() {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BrowsePolicyScreen()));
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: hintColor, width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            kIconBox(Icons.add_circle_outline, kPrimaryColor.withOpacity(0.1), 20.0)
                          ],
                        ),
                        const SizedBox(height: 20.0,),
                        const Row(
                          children: [
                            Text('Browse Policies', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black87),)
                          ],
                        ),
                        const Row(
                          children: [
                            Text('Explore Options', style: TextStyle(color: Colors.black45, fontSize: 11),)
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
                SizedBox(width: 15.0,),
                Expanded(child: GestureDetector(
                  onTap: ()=> showError('You currently have no insurance to claim', context),
                  child: Container(
                    decoration: BoxDecoration(
                      //color: kPrimaryColor,
                      gradient: LinearGradient(
                          colors: [kPrimaryColor,kPrimaryColor,kPrimaryColorDark]),
                      border: Border.all(color: hintColor, width: 0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            kIconBox(Icons.feed_outlined, Colors.white, 20.0)
                          ],
                        ),
                        const SizedBox(height: 20.0,),
                        const Row(
                          children: [
                            Text('Claims', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white),)
                          ],
                        ),
                        const Row(
                          children: [
                            Text('File a claim', style: TextStyle(color: Colors.white, fontSize: 11),)
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
              ],
            ),
          ),
          Divider(color: hintColor,thickness: 0.5,),
          Container(
            margin: EdgeInsets.symmetric(vertical: kComponentDefaultSpacing, horizontal: kPageDefaultPadding),
            padding: EdgeInsets.all(kComponentDefaultSpacing),
            decoration: BoxDecoration(
              border: Border.all(color: hintColor, width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Quick actions', style: kLabelTextStyle,),
                  ],
                ),
                SizedBox(height: kComponentDefaultSpacing,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ColorIconButton(icon: MdiIcons.carOutline, label: 'Car',
                      onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AddVehicleInsuranceScreen())),
                      color: kAccentColor,),
                    ColorIconButton(icon: Icons.home_outlined, label: 'Home',
                      onClick: ()=> showError('The provider is not currently available', context),
                      color: kFourthColor,),
                    ColorIconButton(icon: Icons.favorite_outline,
                      onClick: ()=> showError('The provider is not currently available', context),
                      label: 'Life',color: kTertiaryColor,),
                    ColorIconButton(icon: MdiIcons.airplane,
                      onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTravelInsuranceScreen())),
                      label: 'Travel',),
                  ],
                )
              ],
            ),
          ),
          Divider(color: hintColor,thickness: 0.5,),
          Container(
            margin: EdgeInsets.symmetric(vertical: kComponentDefaultSpacing, horizontal: kPageDefaultPadding),
            padding: EdgeInsets.all(kComponentDefaultSpacing),
            decoration: BoxDecoration(
              border: Border.all(color: hintColor, width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('My Insurances', style: kLabelTextStyle,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.04),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                      padding: EdgeInsets.all(kContainerDefaultPadding),
                      child: Text('0 Active', style: TextStyle(fontSize: 12, color: Colors.black54),),
                    )
                  ],
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.all(kPageDefaultPadding),
                    padding: EdgeInsets.all(kPageDefaultPadding),
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    ),
                    child: Icon(Icons.feed_outlined, size: 30, color: kPrimaryColor,),
                  ),
                ),
                Text('You do not have insurance policies yet', style: TextStyle(color: Colors.black54, fontSize: 13),),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(kComponentDefaultSpacing),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Add your first insurance\t', style: TextStyle(color: kPrimaryColor, fontSize: 13, fontWeight: FontWeight.w600),),
                        Icon(Icons.arrow_forward_ios, size: 15, color: kPrimaryColor,)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),

    );
  }

}