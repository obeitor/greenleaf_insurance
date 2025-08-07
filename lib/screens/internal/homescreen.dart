
import 'package:flutter/material.dart';
import 'package:greenleaf_insurance/components/buttons.dart';
import 'package:greenleaf_insurance/screens/internal/dashboard.dart';
import 'package:greenleaf_insurance/screens/internal/profilescreen.dart';
import 'package:greenleaf_insurance/screens/internal/walletscreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../components/constants.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeState();

}

class _HomeState extends State<HomeScreen>{

  PageController _pageController = PageController();
  int _selectedIndex = 0;
  @override
  void initState(){
    super.initState();
    setState((){
      _pageController = PageController();
    });
  }
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    if(mounted) {
      setState(() {
        _pageController = PageController();
      });
    }
  }
  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                onPageChanged: (int page){
                  setState(() {
                    _selectedIndex = page;
                  });
                },
                controller: _pageController,
                children: [
                  DashboardScreen(),
                  WalletScreen(),
                  ProfileScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: kBottomSheetHeight,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: hintColor, width: 0.2))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomSheetMenuButton(icon: MdiIcons.home,onClick: () => _onPageSelected(0),
              label: 'Home',
              selected: _selectedIndex==0,),
            BottomSheetMenuButton(icon: MdiIcons.cash,onClick: () => _onPageSelected(1),
              label: 'Wallet',
              selected: _selectedIndex==1,),
            BottomSheetMenuButton(icon: MdiIcons.accountCircleOutline,onClick: () => _onPageSelected(2),
              label: 'Profile',
              selected: _selectedIndex==2,),
          ],
        ),
      ),
    );
  }

  void _onPageSelected(int index){
    setState(() {
      if(index!=_selectedIndex) {
        _selectedIndex = index;
        _pageController.animateToPage(index,
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      }
    });
  }
  

}