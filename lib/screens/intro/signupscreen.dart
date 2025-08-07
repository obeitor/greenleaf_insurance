
import 'package:flutter/material.dart';
import 'package:greenleaf_insurance/components/bottom_drawer.dart';
import 'package:greenleaf_insurance/components/components.dart';
import 'package:greenleaf_insurance/services/userservice.dart';

import '../../components/buttons.dart';
import '../../components/constants.dart';
import '../../components/textentries.dart';
import '../../components/utils.dart';
import '../../utils/exceptionutils.dart';
import 'loginscreen.dart';

class SignUpRequest{
  String password = '';
  String confirmPassword = '';
  String firstName = '';
  String lastName = '';
  String middleName = '';
  String phone = '';
  String email = '';
  String NIN = '';
  String gender = '';
  String dob = '';
}

class SignupScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>_SignupState();
}

class _SignupState extends State<SignupScreen>{
  bool _showPassword = false;
  PageController _pageController = PageController();
  int _page = 0;
  List<String> _titles = ['Personal Information','Account Security','KYC Details'];
  late Size _size;
  SignUpRequest _request = SignUpRequest();
  bool _termsAgreement = false;

  TextEditingController _dateOfBirth = TextEditingController();
  UserService _userService = UserService();

  void initState(){
    super.initState();
    setState((){
      _pageController = PageController();
    });
  }
  void didChangeDependencies(){
    if(mounted) {
      setState(() {
        _pageController = PageController();
      });
    }
  }
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kPageDefaultPadding),
          child: Column(
            children: [
              const Row(
                children: [
                  Image(
                    image: const AssetImage('assets/images/greenleaf_logo.png'),
                    height: 50,
                    width: 50,
                    fit: BoxFit.contain,
                    color: kPrimaryColor,
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Create Your Account!', style: kBlackPageTitleStyle,)
                ],
              ),
              const SizedBox(height: kComponentDefaultSpacing,),
              Row(
                children: [
                  Text('Get personalized insurance advice and manage your\npolicies with ease.',style: kBasicTextStyle,textAlign: TextAlign.left,),
                ],
              ),
              const SizedBox(height: kComponentDefaultSpacing,),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Divider(color: kPrimaryColor,thickness: 5,endIndent: 5,)),
                  Expanded(
                      flex: 1,
                      child: Divider(color: _page > 0 ? kPrimaryColor : kLightGrey,thickness: 5,indent: 2.5,endIndent: 2.5,)),
                  Expanded(
                      flex: 1,
                      child: Divider(color: _page > 1 ? kPrimaryColor : kLightGrey,thickness: 5,indent: 5,)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, size: 15, color: kLightGrey,),
                  Text(_titles[_page], style: kPrimaryTextStyle,),
                  Icon(Icons.star, size: 15, color: kLightGrey,),
                ],
              ),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  //onPageChanged: ,
                  controller: _pageController,
                  children: [
                    _firstPage(),
                    _secondPage(),
                    _thirdPage(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _firstPage(){
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                Text('First Name',style: kLabelTextStyle,textAlign: TextAlign.left,),
              ],
            ),
            BasicTextEntryBox(hintText: 'Enter your first name',
              textChange: (v){
                setState(() {
                  _request.firstName = v;
                });
              },
              inputType: TextInputType.name,),
            SizedBox(height: kComponentDefaultSpacing,),
            Row(
              children: [
                Text('Middle Name (Optional)',style: kLabelTextStyle,textAlign: TextAlign.left,),
              ],
            ),
            BasicTextEntryBox(hintText: 'Enter your middle name',
              textChange: (v){
                setState(() {
                  _request.middleName = v;
                });
              },
              inputType: TextInputType.name,),
            SizedBox(height: kComponentDefaultSpacing,),
            Row(
              children: [
                Text('Last Name',style: kLabelTextStyle,textAlign: TextAlign.left,),
              ],
            ),
            BasicTextEntryBox(hintText: 'Enter your last name',
              textChange: (v){
                setState(() {
                  _request.lastName = v;
                });
              },
              inputType: TextInputType.name,),
            SizedBox(height: kComponentDefaultSpacing,),
            Row(
              children: [
                Text('Phone Number',style: kLabelTextStyle,textAlign: TextAlign.left,),
              ],
            ),
            BasicTextEntryBox(hintText: 'Enter your phone number',
              textChange: (v){
                setState(() {
                  _request.phone = v;
                });
              },
              inputType: TextInputType.phone,),
            SizedBox(height: kComponentDefaultSpacing,),
            Row(
              children: [
                Text('Email',style: kLabelTextStyle,textAlign: TextAlign.left,),
              ],
            ),
            BasicTextEntryBox(hintText: 'Enter your email',
              textChange: (v){
                setState(() {
                  _request.email = v;
                });
              },
              inputType: TextInputType.emailAddress,),
            SizedBox(height: kComponentDefaultSpacing,),
            BasicButton(
              enabled: _isPage1Valid(),
              text: 'Continue to Security',width: _size.width*0.9,
              onPress: (){
                setState(() {
                 _page = 1;
                });
                _pageController.animateToPage(_page,
                    duration: Duration(milliseconds: 300), curve: Curves.ease);
              },
            ),
          ],
        ),
      ),
    );
  }

  bool _isPage1Valid(){
    if(_request.phone.startsWith('234')){
      setState(() {
        _request.phone = _request.phone.replaceFirst('234', '0');
      });
    }
    return _request.firstName.isNotEmpty && _request.lastName.isNotEmpty
        && isValidPhone(_request.phone) && isValidEmail(_request.email);
  }

  Container _secondPage(){
    return Container(
      child: Column(
        children: [

          SizedBox(height: kPageDefaultPadding,),
          Row(
            children: [
              Text('Password',style: kLabelTextStyle,textAlign: TextAlign.left,),
            ],
          ),
          PasswordTextEntryBox(hintText: 'Enter your password',viewPassword: _showPassword,
            textChange: (v){
            setState(() {
              _request.password = v;
            });
            },
            viewChange: (()=>setState((){
            _showPassword = !_showPassword;
          })),),
          Row(
            children: [
              Text('Password must contain:', style: kBasicTextStyle,)
            ],
          ),
          PasswordCondition(text: 'At least 8 characters', condition: _request.password.length>7),
          PasswordCondition(text: 'One lower case letter', condition: hasSmallLetter(_request.password)),
          PasswordCondition(text: 'One upper case letter', condition: hasCapitalLetter(_request.password)),
          PasswordCondition(text: 'One number', condition: hasNumber(_request.password)),
          PasswordCondition(text: 'One special character', condition: hasSpecialCharacter(_request.password)),
          SizedBox(height: kComponentDefaultSpacing,),
          Row(
            children: [
              Text('Confirm Password',style: kLabelTextStyle,textAlign: TextAlign.left,),
            ],
          ),
          PasswordTextEntryBox(hintText: 'Confirm your password',viewPassword: _showPassword,
            textChange: (v){
              setState(() {
                _request.confirmPassword = v;
              });
            },
            viewChange: (()=>setState((){
            _showPassword = !_showPassword;
          })),),
          Visibility(
            visible: _request.confirmPassword.isNotEmpty && _request.confirmPassword!=_request.password,
            child: Row(
              children: [
                Text('Passwords do not match', style: kErrorTextStyle,)
              ],
            ),
          ),
          SizedBox(height: kComponentDefaultSpacing,),
          BasicButton(
            enabled: _isPage2Valid(),
            text: 'Continue to KYC Details',width: _size.width*0.9,
            onPress: (){
              setState(() {
                _page = 2;
              });
              _pageController.animateToPage(_page,
                  duration: Duration(milliseconds: 300), curve: Curves.ease);
            },
          ),
          Container(
            padding: EdgeInsets.all(kContainerDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? ",style: kEntryBoxHintStyle,),
                GestureDetector(
                  onTap: ((){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  }),
                  child: Text('Login', style: TextStyle(fontWeight: FontWeight.w600, decoration: TextDecoration.underline,
                      fontSize: 15, color: kPrimaryColor),),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  bool _isPage2Valid(){
    return _request.confirmPassword==_request.password && _request.password.length>7 && hasNumber(_request.password)
        && hasCapitalLetter(_request.password) && hasSmallLetter(_request.password)
        && hasSpecialCharacter(_request.password);
  }

  Container _thirdPage(){
    return Container(
      child: Column(
        children: [

          SizedBox(height: kPageDefaultPadding,),
          Row(
            children: [
              Text('National ID Number (NIN)',style: kLabelTextStyle,textAlign: TextAlign.left,),
            ],
          ),
          BasicTextEntryBox(hintText: 'Enter your NIN',
              textChange: (v){
                setState(() {
                  _request.NIN = v;
                });
              }
          ),
          SizedBox(height: kComponentDefaultSpacing,),
          Row(
            children: [
              Text('Gender',style: kLabelTextStyle,textAlign: TextAlign.left,),
            ],
          ),
          Row(
            children: [
              Expanded(child: SelectorButton(text: 'Male',textColor: _request.gender=='Male'?Colors.white:hintColor,
                onPress: (){
                  setState(() {
                    _request.gender = 'Male';
                  });
                },
                bgColor: _request.gender=='Male'?kPrimaryColor:Colors.white,)),
              SizedBox(width: 10,),
              Expanded(child: SelectorButton(text: 'Female',textColor: _request.gender=='Female'?Colors.white:hintColor,
                onPress: (){
                  setState(() {
                    _request.gender = 'Female';
                  });
                },
                bgColor: _request.gender=='Female'?kPrimaryColor:Colors.white, ))
            ],
          ),
          SizedBox(height: kComponentDefaultSpacing,),
          Row(
            children: [
              Text('Date of Birth',style: kLabelTextStyle,textAlign: TextAlign.left,),
            ],
          ),
          DateEntryBox(controller: _dateOfBirth,),
          Row(
            children: [
              Checkbox(value: _termsAgreement, onChanged: (v){
                setState(() {
                  _termsAgreement = v??false;
                });
              }),
              Text("I agree to Greenleaf's Terms of Service and \nPrivacy Policy", style: kBasicTextStyle,)
            ],
          ),
          SizedBox(height: kComponentDefaultSpacing,),
          BasicButton(
            enabled: _isPage3Valid(),
            text: 'Create Account',width: _size.width*0.9,
            onPress: (){
              showLoader('Signing Up', context, (()async{
                try{
                  await _userService.createAccount(_request);
                  Navigator.pop(context);
                  showSuccess('User created successfully', context, ((){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  }), 'Login');
                }on ApiException catch(e){
                  Navigator.pop(context);
                  showError(e.getMsg(), context);
                }
              }));
            },
          ),
          Container(
            padding: EdgeInsets.all(kContainerDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? ",style: kEntryBoxHintStyle,),
                GestureDetector(
                  onTap: ((){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  }),
                  child: Text('Login', style: TextStyle(fontWeight: FontWeight.w600, decoration: TextDecoration.underline,
                      fontSize: 15, color: kPrimaryColor),),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  bool _isPage3Valid(){
    _request.dob = _dateOfBirth.text;
    return _termsAgreement && _request.dob.isNotEmpty && _request.gender.isNotEmpty && _request.NIN.length==11;
  }

}
