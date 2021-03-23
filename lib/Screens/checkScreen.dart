import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fotodio/Screens/LoginProfile.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fotodio/Models/SignUpModel.dart';
import 'package:fotodio/Screens/ImagePickerScreen.dart';
import 'package:http/http.dart' as http;
import 'package:fotodio/Screens/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class checkScreen extends StatefulWidget {
  final String phone;
  checkScreen(this.phone);
  @override
  _checkScreenState createState() => _checkScreenState();
}
Future<SignUp> createUser(String mobile) async{
  final String apiUrl = "http://fotod.io/api/signup";
  final response = await http.post(apiUrl, body: {
    "mobile": mobile
  });

  if(response.statusCode == 200){
    final String responseString = response.body;
    return signUpFromJson(responseString);
  }else {
    return null;
  }
}
class _checkScreenState extends State<checkScreen> {
  SignUp signup;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ScreenColors().blackColor,
        body:  Container(
        width: MediaQuery.of(context).size.width*100,
          height: MediaQuery.of(context).size.height*100,
          child: Center(
            child: FutureBuilder(
              future:  null, // async work
              builder: (BuildContext context,  snapshot) {
                  return Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      child:SpinKitChasingDots(
                        color: ScreenColors().yellowColor,
                        size: 50.0,
                      ),
                    ),
                  );
                }

            ),
          ),
        ),
      ),
    );
  }


  Future<void> saveToStorage(int userId,String fName, String email, String mobile, String country, String city, String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', userId);
    prefs.setString('firstName', fName);
    prefs.setString('email', email);
    prefs.setString('mobile', mobile);
    prefs.setString('country', country);
    prefs.setString('city', city);
    prefs.setString('address', address);

   print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ImagePickerScreen()));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeUser(widget.phone);
  }

  Future<void> makeUser(var number) async{
    print("aliiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
    signup=await createUser(number);
    print(signup.message);
    print(signup.user.length);
    if(signup.message=="Customer already exist"){
      print("ali");
      print(signup.user[0].userId);
      print( signup.user[0].fName);
      print( signup.user[0].email);
      print(signup.user[0].mobile);
      print(signup.user[0].country);
      print(signup.user[0].city);
      print(signup.user[0].address);
      saveToStorage(signup.user[0].userId, signup.user[0].fName,signup.user[0].email,signup.user[0].mobile,signup.user[0].country,signup.user[0].city,signup.user[0].address);
    }

    else if(signup.message=="new Customer"){
      print(signup.user[0]);
      Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => LoginProfile(widget.phone,signup.user[0].userId)));
    }
  }
}
