
import 'package:flutter/material.dart';

import 'constants.dart';

class BasicButton extends StatelessWidget{
  const BasicButton({super.key,  this.width=100,
    required this.text,
    this.bgColor = kPrimaryColor,
    this.borderColor = kPrimaryColor,
    this.textColor = Colors.white,
    this.onPress,
    this.shadow = false,
    this.enabled = true, this.icon});
  final double width;
  final String text;
  final Color bgColor;
  final bool shadow;

  final Color textColor;

  final Color borderColor;

  final Function()? onPress;
  final IconData? icon;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPress : (() {}),
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        padding: const EdgeInsets.all(15),
        //height: size.height,
        width: width,
        decoration: BoxDecoration(
            border: Border.all(color: enabled ? borderColor : Colors.grey),
            color: bgColor,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                offset: Offset(-5, 3),
                spreadRadius: 4.0,
                blurRadius: 3.0,
                color: Colors.black.withOpacity(shadow ? 0.1 : 0),
              ),
            ]
        ),
        child: Center(
          child: icon==null ? Text(
            text,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: enabled ? textColor : textColor.withOpacity(0.5)),
          ): Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20,color: enabled ? textColor : textColor.withOpacity(0.5),),
              Text(
                text,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: enabled ? textColor : textColor.withOpacity(0.5)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SelectorButton extends StatelessWidget{
  const SelectorButton({super.key,
    required this.text,
    this.bgColor = kPrimaryColor,
    this.textColor = Colors.white,
    this.onPress,});
  final String text;
  final Color bgColor;
  final Color textColor;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: hintColor),
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor ,
          ),
        ),
      ),
    ));
  }
}

class SmallIconOutlineButton extends StatelessWidget{
  final IconData icon;
  final String text;
  final Function()? onClick;
  final Color bgColor;
  final Color textColor;
  final Color borderColor;

  const SmallIconOutlineButton({
    Key? key, this.icon = Icons.radio_button_off,
    required this.text, this.onClick,
    this.bgColor = Colors.white, this.textColor = kPrimaryColor,
    this.borderColor = kPrimaryColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: FittedBox(
        child: Container(
          //width: _size.width*0.6,
          margin: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(color:borderColor ),
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color:  textColor,
                  )),
              SizedBox(width: 4.0,),
              Icon(this.icon,size: 22,color: textColor,),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomSheetMenuButton extends StatelessWidget {
  const BottomSheetMenuButton({super.key,
    required this.icon,
    required this.label,
    required this.selected,
    this.onClick,
    this.notice = false,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final Function()? onClick;
  final bool notice;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width * 0.15;
    return Container(
      child: GestureDetector(
        onTap: onClick,
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(5),
                child: Icon(this.icon,
                    size: 25,
                    color: selected ? kPrimaryColor : Colors.grey)
            ),
            Text(
              this.label,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: selected ? FontWeight.bold : FontWeight.w400,
                  color: selected ? kPrimaryColor : Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}


class ColorIconButton extends StatelessWidget {
  const ColorIconButton({super.key,
    required this.icon,
    required this.label,
    this.onClick,
    this.notice = false,
    this.color = kPrimaryColor,
  });

  final IconData icon;
  final String label;
  final Function()? onClick;
  final bool notice;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: onClick,
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  border: Border.all(color: color, width: 0.3),
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
                padding: const EdgeInsets.all(5),
                child: Icon(this.icon,
                    size: 25,
                    color: color)
            ),
            Text(
              this.label,
              style: kBasicTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class BoxIconButton extends StatelessWidget{

  final IconData icon;
  final String label;
  final Function()? onClick;
  final Color color;

  const BoxIconButton({super.key,
    required this.icon,
    required this.label, this.onClick,
    required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
        child: GestureDetector(
          onTap: onClick,
          child: Container(
            height: 120,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: hintColor, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    border: Border.all(color: color, width: 0.3),
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Icon(this.icon,
                      size: 25,
                      color: color)
              ),
              SizedBox(height: 10.0,),
              Text(
                this.label,
                style: kBasicTextStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
                ),
              ),
        );
  }

}