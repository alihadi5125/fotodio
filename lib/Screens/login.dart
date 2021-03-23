import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:fotodio/Screens/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'otp.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState(){
   super.initState();
   fetchLaguage();
  }
  String Language;
  void fetchLaguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var lan= prefs.getString("language");
    setState(() {
      Language=lan;
    });
  }
  bool validate=false;

  var _controller;
  TextEditingController phonenumber=TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(_controller);
    return SafeArea(
      child: Scaffold(
        backgroundColor:  ScreenColors().blackColor,
        appBar: AppBar(
          backgroundColor: ScreenColors().yellowColor,

          title: Language=="en"?Text('Login', style: TextStyle(
            color: Colors.white,
          ),
          ):Text('تسجيل الدخول', textDirection: TextDirection.rtl,style: TextStyle(
          color: Colors.white,

        ),
      ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
              Container(
                margin: EdgeInsets.only(top: 60),
                child: Center(
                  child: Language=="en"?Text(
                    'Phone Authentication',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28,
                        color:  ScreenColors().yellowColor
                    ),
                  ):Text(
                    'مصادقة الهاتف',  textDirection: TextDirection.rtl,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28,
                        color:  ScreenColors().yellowColor
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40, right: 10, left: 10),
                padding: EdgeInsets.only(
                ),
                child: Theme(
                  data: ThemeData(
                    primaryColor:  ScreenColors().yellowColor.withOpacity(.5),
                    primaryColorDark:  ScreenColors().yellowColor.withOpacity(.5)
                  ),
                  child: IntlPhoneField(
                    controller: phonenumber,
                    dropDownArrowColor: ScreenColors().yellowColor.withOpacity(.8),
                    countryCodeTextColor: ScreenColors().yellowColor.withOpacity(.8),
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      color: ScreenColors().yellowColor
                    ),
                    decoration: InputDecoration(
                      labelText: Language=="en"?'Phone Number':'رقم الهاتف',labelStyle: TextStyle(
                      color:  ScreenColors().yellowColor.withOpacity(.5)
                    ),
                      errorText: validate?null:Language=="en"?"Please Enter Phone Number !":"الرجاء إدخال رقم الهاتف!",

                      enabled: true,
                      enabledBorder:  OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color:  ScreenColors().yellowColor.withOpacity(.8)
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color:  ScreenColors().yellowColor
                        ),
                      ),
                    ),
                    initialCountryCode: 'JO',
                    onChanged: (phone) {
                      print(phone.completeNumber);
                      _controller = phone.completeNumber;
                    },
                  ),
                )
              )
            ]),
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(12.00)
              ),
              child: FlatButton(
                color:  ScreenColors().yellowColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(12.00)
                ),
                onPressed: () {
                  if(checkNumber()){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OTPScreen(_controller)));
                  }
                  else{
                    setState(() {
                      validate=false;
                    });
                  }

                },
                child: Center(
                  child: Text(
                    Language=="en"?"Next":"التالى",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool checkNumber() {
    if(phonenumber.text.isEmpty){
      setState(() {
        validate=true;
      });
      return false;
    }
    else{
      setState(() {
        validate=false;
      });
      return true;
    }
  }
}
