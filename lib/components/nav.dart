import 'package:flutter/material.dart';
import 'package:greenleaf_insurance/components/constants.dart';

class TitleBar extends StatelessWidget{

  final bool showBack;
  final String title;

  const TitleBar({required this.showBack, required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: showBack ?
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Padding(padding: EdgeInsets.all(10), child: Icon(Icons.arrow_back, color: Colors.black,size: 25.0,),)):
            const SizedBox(width: 10,),
          ),
          Expanded(
              flex: 3,
              child: Center(child: Text(title, style: kBlackTitleStyle,),)),
          const Expanded(
              flex: 1,
              child: SizedBox()),
        ],
      ),
    );
  }

}

class SmallTitleBar extends StatelessWidget{

  final bool showBack;
  final String title;

  const SmallTitleBar({required this.showBack, required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: showBack ?
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Padding(padding: EdgeInsets.all(10), child: Icon(Icons.arrow_back, color: kPrimaryColor,size: 20.0,),)):
            const SizedBox(width: 10,),
          ),
          Expanded(
              flex: 3,
              child: Center(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: kPrimaryColor),),)),
          const Expanded(
              flex: 1,
              child: SizedBox()),
        ],
      ),
    );
  }

}