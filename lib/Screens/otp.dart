import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fotodio/Screens/LoginProfile.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fotodio/Models/SignUpModel.dart';
import 'package:fotodio/Screens/ImagePickerScreen.dart';
import 'package:http/http.dart' as http;
import 'package:fotodio/Screens/checkScreen.dart';
import 'package:fotodio/Screens/colors.dart';
class OTPScreen extends StatefulWidget {
  final String phone;
  OTPScreen(this.phone);
  @override
  _OTPScreenState createState() => _OTPScreenState();
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
class _OTPScreenState extends State<OTPScreen> {
  String Language;
  void fetchLaguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var lan= prefs.getString("language");
    setState(() {
      Language=lan;
    });
  }
  SignUp signup;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: ScreenColors().yellowColor.withOpacity(.2),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ScreenColors().blackColor,
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: ScreenColors().yellowColor,
        centerTitle: true,
        title: Text(Language=="en"?'Verify Your Number':"تحقق من رقمك"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                Language=="en"?'Verifying':"التحقق",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: ScreenColors().yellowColor),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                widget.phone,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: ScreenColors().yellowColor),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Center(
              child: Text(
                Language=="en"?"Waiting for SMS.. this will happen":"في انتظار الرسائل القصيرة .. سيحدث هذا",
                style: TextStyle( fontSize: 20, color: ScreenColors().yellowColor),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
               Language=="en"? "Automatically Hold on":"تعليق تلقائي",
                style: TextStyle( fontSize: 20, color: ScreenColors().yellowColor),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: PinPut(
              fieldsCount: 6,
              textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
              onSubmit: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                      verificationId: _verificationCode, smsCode: pin))
                      .then((value) async {
                    if (value.user != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => checkScreen(value.user.phoneNumber)));
//                      Navigator.pushAndRemoveUntil(
//                          context,
//                          MaterialPageRoute(builder: (context) => checkScreen(value.user.phoneNumber)),
//                              (route) => false);
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  _scaffoldkey.currentState
                      .showSnackBar(SnackBar(content: Text('invalid OTP')));
                }
              },
            ),
          )
        ],
      ),
    );
  }
  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => checkScreen(value.user.phoneNumber)));
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
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
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
    fetchLaguage();
  }

  Future<void> makeUser(var number) async{
    signup=await createUser(number);
    return signup;
  }
}
