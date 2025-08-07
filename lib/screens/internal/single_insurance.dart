import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenleaf_insurance/components/nav.dart';

import '../../components/bottom_drawer.dart';
import '../../components/buttons.dart';
import '../../components/constants.dart';
import '../../components/textentries.dart';

class AddVehicleInsuranceScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AddVehicleInsuranceState();

}

class _AddVehicleInsuranceState extends State<AddVehicleInsuranceScreen>{
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                TitleBar(showBack: true, title: 'Third Party Auto'),
                Container(
                  padding: EdgeInsets.all(kPageDefaultPadding),
                  child: Column(
                    children: [

                      Row(
                        children: [
                          Text('Car Make', style: kLabelTextStyle,),
                        ],
                      ),
                      BasicTextEntryBox(hintText: 'Toyota, Honda, Benz, etc',controller: TextEditingController(),inputType: TextInputType.emailAddress,
                        icon: Icons.email_outlined,),
                      SizedBox(height: kComponentDefaultSpacing,),
                      Row(
                        children: [
                          Text('Body Type', style: kLabelTextStyle,),
                        ],
                      ),
                      BasicTextEntryBox(hintText: 'SUV, Sedan, Truck, etc',controller: TextEditingController(),
                        icon: Icons.car_rental,),
                      SizedBox(height: kComponentDefaultSpacing,),
                      Row(
                        children: [
                          Text('Registration Number', style: kLabelTextStyle,),
                        ],
                      ),
                      BasicTextEntryBox(hintText: 'Enter Car Registration Number',controller: TextEditingController(),
                        icon: Icons.app_registration,),
                      SizedBox(height: kComponentDefaultSpacing,),
                      Row(
                        children: [
                          Text('Chassis Number', style: kLabelTextStyle,),
                        ],
                      ),
                      BasicTextEntryBox(hintText: 'Enter Chassis Number',controller: TextEditingController(),
                        icon: Icons.task,),
                      SizedBox(height: kComponentDefaultSpacing,),
                      Row(
                        children: [
                          Text('Engine Number', style: kLabelTextStyle,),
                        ],
                      ),
                      BasicTextEntryBox(hintText: 'Enter Engine Number',controller: TextEditingController(),
                        icon: Icons.settings,),
                      SizedBox(height: kComponentDefaultSpacing,),

                      BasicButton(
                        onPress: ()=>getPolicyCreationSummary(context, 'Auto Policy', 'Sovereign Trust', 6000,'annually',
                            ['Covers against damage of another vehicle','Covers against medical, compensation and death benefits of another person']),
                        text: 'Proceed',width: _size.width*0.9,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}


class AddGadgetInsuranceScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AddGadgetInsuranceState();

}

class _AddGadgetInsuranceState extends State<AddGadgetInsuranceScreen>{
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: lightOffWhite,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                TitleBar(showBack: true, title: 'Gadget Policy'),
                Container(
                  padding: EdgeInsets.all(kPageDefaultPadding),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Item Name', style: kBasicTextStyle,),
                        ],
                      ),
                      BasicTextEntryBox(hintText: 'E.g Playstation, Samsung Phone',controller: TextEditingController(),
                        icon: Icons.device_hub,isEditable: true,),
                      SizedBox(height: kComponentDefaultSpacing,),
                      Row(
                        children: [
                          Text('Item Value', style: kBasicTextStyle,),
                        ],
                      ),
                      BasicTextEntryBox(hintText: 'Enter value of item',controller: TextEditingController(),
                        icon: Icons.monetization_on,isEditable: true,inputType: TextInputType.number,),

                      SizedBox(height: kComponentDefaultSpacing,),

                      BasicButton(
                        onPress: ()=>getPolicyCreationSummary(context, 'Gadget Policy', 'Sovereign Trust', 3000,'annually',
                            ['Covers against theft of item','Covers against damage of item']),
                        text: 'Proceed',width: _size.width*0.9,),
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

}


class AddTravelInsuranceScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AddTravelInsuranceState();

}

class _AddTravelInsuranceState extends State<AddTravelInsuranceScreen>{
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: lightOffWhite,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                TitleBar(showBack: true, title: 'Travel'),
                Container(
                  padding: EdgeInsets.all(kPageDefaultPadding),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Duration (Days)', style: kBasicTextStyle,),
                        ],
                      ),
                      BasicTextEntryBox(hintText: 'Duration in days',
                        icon: Icons.calendar_today_outlined, inputType: TextInputType.number,
                        controller: TextEditingController(text: ''),),
                      SizedBox(height: kComponentDefaultSpacing,),
                      Row(
                        children: [
                          Text('Departure Location', style: kBasicTextStyle,),
                        ],
                      ),
                      BasicTextEntryBox(hintText: 'Enter Departure Location',controller: TextEditingController(),
                        icon: Icons.place,isEditable: true,),
                      SizedBox(height: kComponentDefaultSpacing,),
                      Row(
                        children: [
                          Text('Arrival Location', style: kBasicTextStyle,),
                        ],
                      ),
                      BasicTextEntryBox(hintText: 'Enter Private or Commercial',controller: TextEditingController(),
                        icon: Icons.place,isEditable: true,),

                      SizedBox(height: kComponentDefaultSpacing,),

                      BasicButton(
                        onPress: ()=>getPolicyCreationSummary(context, 'Travel Policy', 'Sovereign Trust', 2000,'',
                            ['Covers Emergency Medical Expenses','Covers Accidental Death or Permanent Disability']),
                        text: 'Proceed',width: _size.width*0.9,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}