import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenleaf_insurance/components/bottom_drawer.dart';
import 'package:greenleaf_insurance/components/buttons.dart';
import 'package:greenleaf_insurance/components/constants.dart';
import 'package:greenleaf_insurance/models/transactionmodels.dart';
import 'package:greenleaf_insurance/services/walletservice.dart';
import 'package:greenleaf_insurance/utils/exceptionutils.dart';

import '../../components/nav.dart';
import '../../services/userservice.dart';

class WalletScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _WalletState();

}

class _WalletState extends State<WalletScreen>{
  double? _balance;
  WalletService _walletService = WalletService();
  List<WalletTransaction> _recent = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchBalances();
    _fetchRecentTransactions();
  }

  void _fetchBalances()async{
    try {
      double bal = await _walletService.balance();
      setState(() {
        _balance = bal;
      });
    }
    on ApiException catch(e){
      print(e.getMsg());
    }
  }

  void _fetchRecentTransactions()async{
    try{
      List<WalletTransaction> ls = await _walletService.recent();
      setState(() {
        _recent.clear();
        _recent.addAll(ls);
      });
    }
    on ApiException catch(e){
      print(e.getMsg());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(kPageDefaultPadding),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            TitleBar(showBack: false, title: 'Wallet'),
            Container(
              width: _size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [kPrimaryColor,kPrimaryColor,kPrimaryColorDark]),
                border: Border.all(color: hintColor, width: 0.5),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Wallet Balance', style: kWhiteTextStyle,),
                  Text(_balance==null?'---.--':moneyFormat.format(_balance), style: kBoldWhiteProfileTextStyle,),
                  Padding(
                      padding: EdgeInsets.all(kContainerDefaultPadding),
                    child: BasicButton(text: 'Top Up', bgColor: Colors.white, width: _size.width,
                      onPress: () => getAmount(1000, context),
                      textColor: kPrimaryColorDark,icon: Icons.add,),
                  )
                ],
              ),
            ),
            const SizedBox(height: kComponentDefaultSpacing,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Transactions', style: kBasicTextStyle,),
                GestureDetector(
                  child: Text('See all', style: kPrimaryTextStyle,),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

}