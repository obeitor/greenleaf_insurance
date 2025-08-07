import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenleaf_insurance/components/constants.dart';

class PasswordCondition extends StatelessWidget{

  final String text;
  final bool condition;

  const PasswordCondition({super.key, required this.text, required this.condition});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: condition ? kPrimaryColor : Colors.grey,
              child:  Icon(condition ? Icons.check : Icons.close, color: Colors.white,size: 12,)
          ),
          SizedBox(width: 5,),
          Text(text, style: kBasicTextStyle,)
        ],
      ),
    );
  }

}