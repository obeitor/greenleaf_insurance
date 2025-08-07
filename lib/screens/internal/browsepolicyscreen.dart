import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenleaf_insurance/components/buttons.dart';
import 'package:greenleaf_insurance/components/constants.dart';
import 'package:greenleaf_insurance/components/nav.dart';
import 'package:greenleaf_insurance/screens/internal/single_insurance.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../components/bottom_drawer.dart';

class BrowsePolicyScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _BrowsePolicyState();

}

class _BrowsePolicyState extends State<BrowsePolicyScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                TitleBar(showBack: true, title: 'Choose Insurance Type'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                   BoxIconButton(
                     onClick: ()=> showError('The provider is not currently available', context),
                       icon: MdiIcons.carOutline, label: 'Comprehensive\nMotor Insurance', color: kPrimaryColor),
                    BoxIconButton(
                      onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>AddVehicleInsuranceScreen())),
                        icon: MdiIcons.carSide, label: 'Third Party\nInsurance (Private)', color: kPrimaryColor)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BoxIconButton(
                      onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTravelInsuranceScreen())),
                        icon: MdiIcons.airplane, label: 'Travel Insurance', color: kPrimaryColor),
                    BoxIconButton(
                      onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>AddGadgetInsuranceScreen())),
                        icon: MdiIcons.devices, label: 'Gadget Insurance', color: kPrimaryColor)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}