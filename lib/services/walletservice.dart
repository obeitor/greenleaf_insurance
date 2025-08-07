
import 'dart:convert';

import 'package:greenleaf_insurance/utils/apiutils.dart' as ApiUtils;

import '../models/transactionmodels.dart';
class WalletService{

  Future<double> balance()async{
    var rsp = await ApiUtils.makeRequest(ApiUtils.RequestType.GET, '/wallet/balance', null, null);
    Map<String,dynamic> result = ApiUtils.getResponse(rsp);
    return double.parse(result['balance']);
  }
  
  Future<List<WalletTransaction>> recent()async{
    var rsp = await ApiUtils.makeRequest(ApiUtils.RequestType.GET, '/wallet/transactions', null, null);
    Map<String,dynamic> result = ApiUtils.getResponse(rsp);
    List ls = result['transactions'];
    List<WalletTransaction> txns = [];
    for (var e in ls) {
      txns.add(WalletTransaction.fromJson(e));
    }
    return txns;
  }

  Future<CreditRequest> credit(double amount, String desc)async{
    var data = {
      'amount': amount,
      'description': 'CR|$desc',
    };
    var rsp = await ApiUtils.makeRequest(ApiUtils.RequestType.POST, '/wallet/fund', jsonEncode(data), null);
    Map<String,dynamic> result = ApiUtils.getResponse(rsp);
    return CreditRequest.fromJson(result);
  }

  Future<void> debit(double amount, String desc)async{
    var data = {
      'amount': amount,
      'description': 'DR|$desc',
    };
    var rsp = await ApiUtils.makeRequest(ApiUtils.RequestType.POST, '/wallet/debit', jsonEncode(data), null);
    ApiUtils.getResponse(rsp);
  }

}