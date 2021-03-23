

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fotodio/Screens/LoginProfile.dart';
import 'package:fotodio/Screens/ImagePickerScreen.dart';
import 'package:fotodio/Screens/PlaceOrderScreen.dart';
import 'package:fotodio/Screens/login.dart';
import 'package:fotodio/Screens/checkScreen.dart';
import 'package:fotodio/Screens/onBordingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fotodio/Screens/Language.dart';
import 'package:fotodio/Screens/otp.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  var userId;
  var login;
  var name;
  var email ;
  var mobile;
  var country;
  var city;
  var address;
  bool Check=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: AnimatedSplashScreen(
        duration: 2000,
        splash:  Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/logo.jpg'),
                  fit: BoxFit.fitHeight
              )
          ),
        ),
        splashIconSize: 200,
        nextScreen:Check==false?Language():ImagePickerScreen(),


        splashTransition: SplashTransition.slideTransition,
        pageTransitionType: PageTransitionType.leftToRight,
        //backgroundColor: Color(0xffFFFFFF),
      ),
    );
  }

  void checkLogin() async {
    print("--------------------------------------");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userIdd=prefs.getInt('userId');
    var  loginCheck = prefs.getString('login');
    var  nameCheck = prefs.getString('firstName');
    var  emailCheck = prefs.getString('email');
    var mobileCheck = prefs.getString('mobile');
    var countryCheck = prefs.getString('country');
    var cityCheck = prefs.getString('city');
    var addressCheck = prefs.getString('address');
    if(loginCheck=="true" && nameCheck!=null && emailCheck!=null && mobileCheck!=null && countryCheck!=null && cityCheck!=null && addressCheck!=null && userIdd!=null){
      setState(() {
        print("****************************************");
        Check=true;
        userId=userIdd;
        mobile=mobileCheck;
      });
    }
    else{
      setState(() {
        print("''''''''''''''''''''''''''''''''''''''''''''''");
        Check=false;
      });
    }

  }
}