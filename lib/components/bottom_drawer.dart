import 'package:flutter/material.dart';
import 'package:greenleaf_insurance/components/nav.dart';
import 'package:greenleaf_insurance/components/progress_bar.dart';
import 'package:greenleaf_insurance/components/textentries.dart';
import 'package:greenleaf_insurance/components/webview.dart';
import 'package:greenleaf_insurance/components/wrappers.dart';
import 'package:greenleaf_insurance/models/transactionmodels.dart';
import 'package:greenleaf_insurance/services/walletservice.dart';

import '../utils/exceptionutils.dart';
import 'buttons.dart';
import 'constants.dart';


void showError(String msg, BuildContext context){
  showModalBottomSheet(context: context,
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
      elevation: 30,
      isDismissible: false,
      isScrollControlled: true,
      builder: (context) =>   ModifiableBottomDrawer(message: msg,icon: Icons.error,color: Colors.redAccent,
        buttonFunction: (() {}),
        btnColor: kSecondaryColor,
        buttonText: 'Close',));
}

void showSuccess(String msg, BuildContext context, Function onPress, String btnText){
  showModalBottomSheet(context: context,
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
      elevation: 30,
      isDismissible: false,
      isScrollControlled: true,
      builder: (context) =>   ModifiableBottomDrawer(message: msg,icon: Icons.gpp_good_rounded,color: kPrimaryColorLight,
        buttonFunction: onPress,
        buttonText: btnText,));
}

class ModifiableBottomDrawer extends StatelessWidget{
  final String message;
  final IconData icon;
  final Function buttonFunction;
  final String buttonText;
  final Color color;
  final Color btnColor;

  const ModifiableBottomDrawer({super.key,
    required this.message, required this.icon,
    required this.buttonFunction, required this.buttonText,
    this.btnColor = kPrimaryColor,
    required this.color});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: kBottomDrawerHeight,
      child: Stack(
        children: [
          Positioned(
            top: 35.0,
            height: kBottomDrawerHeight - 35.0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20)
                ),
              ),
              padding: const EdgeInsets.all(kPageDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: kPageDefaultPadding,),
                  Text(message,style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black),),
                  const SizedBox(height: kPageDefaultPadding+kPageDefaultPadding,),
                  BasicButton(
                    width: size.width*0.9,
                    text: this.buttonText,
                    bgColor: btnColor,borderColor: btnColor,onPress: ((){
                      Navigator.pop(context);
                      this.buttonFunction();
                    }),)
                ],
              ),
            ),
          ),
          Positioned(
              height: 70,
              top: 0,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40)
                      ),
                    ),
                    child: Icon(this.icon, size: 60.0,color: this.color,),
                  ),
                ],
              )),
        ],
      ),
    );
  }

}

void getPolicyCreationSummary(BuildContext context,String policyName, String providerName, double amount,String duration, List<String> benefits)async{
  WalletService walletService = WalletService();
  double bal = await walletService.balance();

  showModalBottomSheet(context: context,
      isDismissible: false,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(builder: (BuildContext ctxx, StateSetter setter){
        return Container(
          padding: EdgeInsets.all(10.0),
          height: 400,
          child: Column(
            children: [
              SmallTitleBar(showBack: true, title: 'Policy Details'),
              Container(
                margin: EdgeInsets.all(kComponentDefaultSpacing),
                padding: EdgeInsets.all(kComponentDefaultSpacing),
                decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.1)
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(policyName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: kPrimaryColor),),
                      ],
                    ),
                    Row(
                      children: [
                        RichText(text: TextSpan(
                            style: kEntryBoxHintStyle,
                            children: [
                              const TextSpan(text: 'Provided by '),
                              TextSpan(text: providerName, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                            ]
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Text('${moneyFormat.format(amount)} - $duration', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: kPrimaryColor),),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Row(
                  children: [
                    Text('Benefits', style: kBoldBasicTextStyle,),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: benefits.map((item) => Row(
                    children: [
                      Expanded(child: Text('• $item')),
                    ],
                  )).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BasicButton(text: 'Decline',
                    bgColor: Colors.white,
                    borderColor: hintColor,
                    textColor: Colors.blueGrey,
                    onPress: ()=>Navigator.pop(context),
                    width: MediaQuery.of(context).size.width*0.4,
                  ),

                  BasicButton(text: 'Accept',
                    onPress: ((){
                      if(amount>bal){
                        Navigator.pop(context);
                        getAmount(amount, context);
                      }
                      else{
                        showLoader('Processing your insurance policy', context, ()async{
                          await Future.delayed(Duration(seconds: 10));
                          Navigator.pop(context);
                          showError('Insurance Provider did not respond. Kindly try again later.\nFunds have been refunded to your wallet.', context);
                        });
                      }
                    }),
                    width: MediaQuery.of(context).size.width*0.4,
                  )
                ],
              )
            ],
          ),
        );
      }));
}


void getAmount(double min, BuildContext context){
  double amount = 0;
  const double charges = 250;
  const double percentage = 0.04;
  WalletService walletService = WalletService();
  showModalBottomSheet(context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (context) => StatefulBuilder(builder: (BuildContext ctx, StateSetter setter){
        return Container(
          padding: EdgeInsets.all(10.0),
          height: 400,
          child: Column(
            children: [
              SmallTitleBar(showBack: true, title: 'Fund Account'),
              Container(
                margin: EdgeInsets.all(kComponentDefaultSpacing),
                padding: EdgeInsets.all(kComponentDefaultSpacing),
                decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.1)
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Amount to Fund:', style: kLabelTextStyle,),
                        Text(moneyFormat.format(amount), style: kPrimaryTextStyle,)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Charges:', style: kLabelTextStyle,),
                        Text(moneyFormat.format(percentage*amount), style: kPrimaryTextStyle,)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total to Pay:', style: kLabelTextStyle,),
                        Text(moneyFormat.format(amount+(percentage*amount)), style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: kPrimaryColor),)
                      ],
                    ),
                  ],
                ),
              ),
              MoneyEntryBox(
                onChanged: ((v){
                  setter((){
                    try {
                      amount = MoneyEntryBox.format.parse(v).toDouble();
                    }catch(e){
                      amount = 0;
                    }
                  });
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Minimum Amount:', style: kLabelTextStyle,),
                    Text(moneyFormat.format(min), style: kEntryBoxHintStyle,)
                  ],
                ),
              ),
              BasicButton(text: 'Make Payment', enabled: min<=amount,
                onPress: ((){
                  showLoader('Connecting to Payment Provider', context, ()async{
                    try {
                      CreditRequest req = await walletService.credit(
                          amount + charges, 'Funding');
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          WebViewPage(initUrl: req.paymentUrl!, urlToPop: 'https://www.greenleafib.com/',)
                      ));
                    }on ApiException catch(e){
                      Navigator.pop(context);
                      showError(e.getMsg(), context);
                    }
                  });
                }), width: MediaQuery.of(context).size.width*0.9,)
            ],
          ),
        );
      }));
}

void showLoader(String message,BuildContext context, Function onLoading){
  showModalBottomSheet(context: context,
      isDismissible: false,
      isScrollControlled: true,
      builder: (context) => LoadingDrawer(text: message,function: onLoading,) );
}

class LoadingDrawer extends StatelessWidget{
  final String text;
  final Function? function;
  const LoadingDrawer({super.key, required this.text, this.function});
  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: ()async{
        if(function!=null){
          await function!();
        }
      } ,
      child: Container(
        height: kBottomDrawerHeight,
        padding: const EdgeInsets.all(kPageDefaultPadding),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(20)
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            kDrawerHandle,
            Text(text,style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),
            const SizedBox(height: kPageDefaultPadding,),
            const CustomProgressIndicatorWidget(),
          ],
        ),
      ),
    );
  }

}