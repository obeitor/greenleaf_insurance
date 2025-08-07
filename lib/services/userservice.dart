import 'dart:convert';

import 'package:greenleaf_insurance/screens/intro/signupscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:greenleaf_insurance/utils/apiutils.dart' as ApiUtils;

import '../models/usermodels.dart';

class UserService{
  Future<void> _saveToken(String token)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('token', token);
  }

  Future<void> _clearToken()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', '');
  }

  Future<void> createAccount(SignUpRequest request)async{
    var data = {
      "firstName": request.firstName,
      "lastName": request.lastName,
      "middleName": request.middleName,
      "gender": request.gender,
      "email": request.email,
      "phone": request.phone,
      "password": request.password,
      "dateOfBirth": request.dob,
      "nin":request.NIN
    };
    var rsp = await ApiUtils.makeRequest(ApiUtils.RequestType.POST, '/auth/signup', jsonEncode(data), null);
    ApiUtils.getResponse(rsp);
  }

  Future<String> login(String email, String password)async{
    var data = {
      "email":email,
      "password":password
    };
    var rsp = await ApiUtils.makeRequest(ApiUtils.RequestType.POST, '/auth/login', jsonEncode(data), null);
    Map<String,dynamic> result = ApiUtils.getResponse(rsp);
    String token = result['token'];
    await _saveToken(token);
    return token;
  }

  Future<void> logout()async{
    await _clearToken();
  }

  Future<User> me()async{
    var rsp = await ApiUtils.makeRequest(ApiUtils.RequestType.GET, '/auth/me', null, null);
    Map<String,dynamic> result = ApiUtils.getResponse(rsp);
    return User.fromJson(result);
  }

  Future<String> myReferral()async{
    var rsp = await ApiUtils.makeRequest(ApiUtils.RequestType.GET, '/auth/me/referral', null, null);
    Map<String,dynamic> result = ApiUtils.getResponse(rsp);
    return result['code'];
  }


}