
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'constants.dart';

class MoneyEntryBox extends StatelessWidget{
  static NumberFormat format =  NumberFormat("₦#,###.00#", "en_US");
  final String  hintText;
  final bool disabled;
  final Function(String)? onSubmit;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final double initialValue;
  final focusNode;
  final TextEditingController? controller;
  MoneyEntryBox({super.key,  this.hintText='', this.disabled = false, this.onSubmit, this.onChanged, this.onSaved, this.initialValue=0, this.focusNode, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(5)
      ),
      child: TextFormField(
        onChanged: onChanged,
        /*inputFormatters: <TextInputFormatter>[CurrencyTextInputFormatter(format,
            enableNegative: false, minValue: 0,
            //onChange: onChanged
        )],*/
        controller: controller,
        textAlign: TextAlign.left,
        onSaved: onSaved,
        obscureText: false,
        keyboardType: const TextInputType.numberWithOptions(
            signed: true, decimal: true
        ),
        enabled: !disabled,
        onFieldSubmitted: onSubmit,
        style: kEntryBoxTextStyle,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
          hintText: hintText,
          hintStyle: kEntryBoxHintStyle,
        ),
      ),
    );
  }
}

class PasswordTextEntryBox extends StatelessWidget{
  const PasswordTextEntryBox({
    Key? key,
    this.hintText = "",
    this.viewPassword = false,
    this.inputType = TextInputType.text,
    this.controller,
    this.isEditable = true,
    this.textChange,
    this.viewChange,
    this.icon,
  }):super(key: key);

  final String hintText;
  final bool viewPassword;
  final TextInputType inputType;
  final TextEditingController? controller;
  final bool isEditable;
  final Function(String)? textChange;
  final Function()? viewChange;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: hintColor, width: 0.5),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(icon!=null)
            Padding(
              padding: const EdgeInsets.all(kComponentDefaultSpacing),
              child: Icon(Icons.password, color: hintColor,),
            ),
          Expanded(
            flex: 8,
            child: TextFormField(
              onChanged: textChange,
              controller: controller,
              textAlign: TextAlign.left,
              obscureText: !viewPassword,
              keyboardType: inputType,
              enabled: isEditable,

              style: kEntryBoxTextStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                counterText: '',
                hintText: hintText,
                hintStyle: kEntryBoxHintStyle,
              ),
            ),
          ),
          GestureDetector(
            onTap: viewChange,
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Icon(viewPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 18,color: hintColor,),
            ),
          )
        ],
      ),
    );
  }
}

class DateEntryBox extends StatelessWidget{
  const DateEntryBox({
    Key? key,
    this.icon,
    this.hintText = "yyyy-MM-dd",
    this.inputType = TextInputType.datetime,
    required this.controller,
    this.isEditable = true,
    this.textChange,
    this.initialVal = '',
  }):super(key: key);

  final String initialVal;
  final IconData? icon;
  final String hintText;
  final TextInputType inputType;
  final TextEditingController controller;
  final bool isEditable;
  final Function(String)? textChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: hintColor, width: 0.5)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(icon!=null)
            Padding(
              padding: const EdgeInsets.all(kComponentDefaultSpacing),
              child: Icon(icon, color: hintColor,),
            ),
          Expanded(
            flex: 8,
            child: TextFormField(
              onChanged: textChange,
              controller: controller,
              textAlign: TextAlign.left,
              keyboardType: inputType,
              readOnly: true,
              style: kEntryBoxTextStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                counterText: '',
                hintText: hintText,
                hintStyle: kEntryBoxHintStyle,
                suffixIcon: Icon(Icons.calendar_month, size: 16,color: hintColor,)
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BasicTextEntryBox extends StatelessWidget{
  const BasicTextEntryBox({
    Key? key,
    this.icon,
    this.hintText = "",
    this.inputType = TextInputType.text,
    this.controller,
    this.isEditable = true,
    this.textChange,
    this.initialVal = '',
  }):super(key: key);

  final String initialVal;
  final IconData? icon;
  final String hintText;
  final TextInputType inputType;
  final TextEditingController? controller;
  final bool isEditable;
  final Function(String)? textChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: hintColor, width: 0.5)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(icon!=null)
            Padding(
              padding: const EdgeInsets.all(kComponentDefaultSpacing),
              child: Icon(icon, color: hintColor,),
            ),
          Expanded(
            flex: 8,
            child: TextFormField(
              onChanged: textChange,
              controller: controller,
              textAlign: TextAlign.left,
              keyboardType: inputType,
              enabled: isEditable,
              //initialValue: initialVal,
              style: kEntryBoxTextStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                counterText: '',
                hintText: hintText,
                hintStyle: kEntryBoxHintStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}