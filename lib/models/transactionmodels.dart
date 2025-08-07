class WalletTransaction{
  double amount = 0;
  String description = '';
  bool isCredit = true;
  String dateTime = '';
  WalletTransaction();

  factory WalletTransaction.fromJson(Map<String, dynamic> json){
    WalletTransaction transaction = WalletTransaction();
    transaction.amount = double.parse(json['amount']);
    transaction.description = json['description'];
    transaction.isCredit = json['type']=='credit';
    transaction.dateTime = json['created_at'];
    return transaction;
  }
}

class CreditRequest{
  String paymentUrl = '';

  CreditRequest();

  factory CreditRequest.fromJson(Map<String,dynamic> json){
    CreditRequest request = CreditRequest();
    request.paymentUrl = json['paymentUrl'];
    return request;
  }
}