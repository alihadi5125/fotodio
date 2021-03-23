
import 'package:flutter/material.dart';
import 'package:fotodio/Screens/colors.dart';
import 'package:fotodio/Screens/modelclasses/UpdateProfile.dart';
import 'package:http/http.dart' as http;
import 'package:fotodio/Screens/ImagePickerScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginProfile extends StatefulWidget {
  String mobile;
  int userId;
  LoginProfile([this.mobile, this.userId]);
  @override
  _LoginProfileState createState() => _LoginProfileState();
}
Future<UpdateProfile> updateProfile(int userId,String f_Name, String email, String mobile, String country, String city, String adress) async {

  final String apiUrl = "http://fotod.io/api/profile";
  final response = await http.post(apiUrl, body: {

    "userID" : userId.toString(),
    "f_Name" : f_Name,
    "email"   :  email,
    "mobile" : mobile,
    "country" : country,
    "city":city,
    "address" : adress
  });

  if (response.statusCode == 200) {
    final String responseString = response.body;
    print(responseString);
    return UpdateProfile.fromRawJson(responseString);
  } else {
    return null;
  }
}
class _LoginProfileState extends State<LoginProfile> {
  String Language;
  void fetchLaguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var lan= prefs.getString("language");
    setState(() {
      Language=lan;
    });
  }

  UpdateProfile profile;
  final name = TextEditingController();
  final email = TextEditingController();
  final adress = TextEditingController();
  final adressLine2 = TextEditingController();
  final zip = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  bool nameValidate = false;
  bool emailValidate = false;
  bool phoneValidate = false;
  bool adressValidate = false;
  bool addressLineValidate = false;
  bool zipValidate = false;
  bool cityValidate = false;
  bool stateValidate = false;
  bool countryValidate = false;

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();
  FocusNode f6 = FocusNode();
  FocusNode f7 = FocusNode();
  FocusNode f8 = FocusNode();
  FocusNode f9 = FocusNode();
  FocusNode f10 = FocusNode();

  bool checkboxValue = false;

  void initState() {
    var boolcheckboxValue = false;
    super.initState();
    fetchLaguage();
    print(widget.userId);
    print(widget.mobile);
    saveIDandPhone(widget.userId, widget.mobile);
  }

  @override
  Widget build(BuildContext context) {
  saveIDandPhone(widget.userId, widget.mobile);
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ScreenColors().yellowColor,
            shadowColor: ScreenColors().yellowColor,
            centerTitle: true,
            title: Text(
              Language=="en"?"Update Profile":"تحديث الملف",
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: ScreenColors().blackColor,
          body: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: MediaQuery.of(context).size.height*.05),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: TextField(
                            controller: name,
                            style: TextStyle(color: ScreenColors().yellowColor),
                            textInputAction: TextInputAction.next,
                            focusNode: f1,
                            keyboardType: TextInputType.name,
                            onChanged: (String name) {
                              if (name.isEmpty) {
                                setState(() {
                                  nameValidate = true;
                                });
                                FocusScope.of(context).requestFocus(f1);
                              } else {
                                setState(() {
                                  nameValidate = false;
                                });
                              }
                            },
                            decoration: InputDecoration(
                                hintText: Language=="en"?'Name':'اسم',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ScreenColors()
                                          .yellowColor
                                          .withOpacity(.5)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ScreenColors().yellowColor),
                                ),
                                errorText:
                                    nameValidate ? Language=="en"?"Name is Mandotory":"الاسم إلزامي" : null,
                                hintStyle: TextStyle(
                                    color: ScreenColors()
                                        .yellowColor
                                        .withOpacity(.8))),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: TextField(
                                    style: TextStyle(
                                        color: ScreenColors().yellowColor),
                                    controller: email,
                                    textInputAction: TextInputAction.next,
                                    focusNode: f2,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ScreenColors()
                                                  .yellowColor
                                                  .withOpacity(.5)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  ScreenColors().yellowColor),
                                        ),
                                        hintText: Language=="en"?'Email':'البريد الإلكتروني',
                                        errorText: emailValidate
                                            ? Language=="en"?"Email is mandatory":"البريد الإلكتروني إلزامي"
                                            : null,
                                        hintStyle: TextStyle(
                                            color: ScreenColors()
                                                .yellowColor
                                                .withOpacity(.8))),
                                    onChanged: (String email) {
                                      if (email.isEmpty) {
                                        setState(() {
                                          emailValidate = true;
                                        });
                                        FocusScope.of(context).requestFocus(f2);
                                      } else {
                                        setState(() {
                                          emailValidate = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: TextField(
                            style: TextStyle(color: ScreenColors().yellowColor),
                            controller: adress,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ScreenColors()
                                          .yellowColor
                                          .withOpacity(.5)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ScreenColors().yellowColor),
                                ),
                                hintText: Language=="en"?'Address':'عنوان',
                                errorText: adressValidate
                                    ? Language=="en"?"Adress is Mandatory":"العنوان إلزامي"
                                    : null,
                                hintStyle: TextStyle(
                                    color: ScreenColors()
                                        .yellowColor
                                        .withOpacity(.8))),
                            onChanged: (String name) {
                              if (name.isEmpty) {
                                setState(() {
                                  adressValidate = true;
                                });
                                FocusScope.of(context).requestFocus(f4);
                              } else {
                                setState(() {
                                  adressValidate = false;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: TextField(
                            style: TextStyle(color: ScreenColors().yellowColor),
                            controller: adressLine2,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ScreenColors()
                                          .yellowColor
                                          .withOpacity(.5)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ScreenColors().yellowColor),
                                ),
                                hintText: Language=="en"?"Adress Line 2":'سطر العنوان 2',
                                hintStyle: TextStyle(
                                    color: ScreenColors()
                                        .yellowColor
                                        .withOpacity(.8))),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: TextField(
                                    style: TextStyle(
                                        color: ScreenColors().yellowColor),
                                    controller: zip,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ScreenColors()
                                                  .yellowColor
                                                  .withOpacity(.5)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  ScreenColors().yellowColor),
                                        ),
                                        hintText: Language=="en"?'ZIP/Post Code':"الرمز البريدي",
                                        errorText: zipValidate
                                            ? Language=="en"?"Zip Code is Mandatory":"الرمز البريدي إلزامي"
                                            : null,
                                        hintStyle: TextStyle(
                                            color: ScreenColors()
                                                .yellowColor
                                                .withOpacity(.8))),
                                    onChanged: (String name) {
                                      if (name.isEmpty) {
                                        setState(() {
                                          zipValidate = true;
                                        });
                                        FocusScope.of(context).requestFocus(f6);
                                      } else {
                                        setState(() {
                                          zipValidate = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  child: TextField(
                                    style: TextStyle(
                                        color: ScreenColors().yellowColor),
                                    controller: city,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ScreenColors()
                                                  .yellowColor
                                                  .withOpacity(.5)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  ScreenColors().yellowColor),
                                        ),
                                        hintText: Language=="en"?'City':'مدينة',
                                        errorText: cityValidate
                                            ? Language=="en"?"City is Mandatory":"المدينة إلزامية"
                                            : null,
                                        hintStyle: TextStyle(
                                            color: ScreenColors()
                                                .yellowColor
                                                .withOpacity(.8))),
                                    onChanged: (String name) {
                                      if (name.isEmpty) {
                                        setState(() {
                                          cityValidate = true;
                                        });
                                        FocusScope.of(context).requestFocus(f7);
                                      } else {
                                        setState(() {
                                          cityValidate = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: TextField(
                                    style: TextStyle(
                                        color: ScreenColors().yellowColor),
                                    controller: state,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ScreenColors()
                                                  .yellowColor
                                                  .withOpacity(.5)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  ScreenColors().yellowColor),
                                        ),
                                        hintText: Language=="en"?'State/Province/Region':'الدولة / الإقليم / المنطقة',
                                        errorText: stateValidate
                                            ? Language=="en"?"State is Mandatory":"الدولة إلزامية"
                                            : null,
                                        hintStyle: TextStyle(
                                            color: ScreenColors()
                                                .yellowColor
                                                .withOpacity(.8))),
                                    onChanged: (String name) {
                                      if (name.isEmpty) {
                                        setState(() {
                                          stateValidate = true;
                                        });
                                        FocusScope.of(context).requestFocus(f8);
                                      } else {
                                        setState(() {
                                          stateValidate = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  child: TextField(
                                    style: TextStyle(
                                        color: ScreenColors().yellowColor),
                                    controller: country,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ScreenColors()
                                                  .yellowColor
                                                  .withOpacity(.5)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  ScreenColors().yellowColor),
                                        ),
                                        hintText: Language=="en"?'Country':'بلد',
                                        errorText: countryValidate
                                            ? Language=="en"?"Country is Mandatory":"البلد إلزامي"
                                            : null,
                                        hintStyle: TextStyle(
                                            color: ScreenColors()
                                                .yellowColor
                                                .withOpacity(.8))),
                                    onChanged: (String name) {
                                      if (name.isEmpty) {
                                        setState(() {
                                          countryValidate = true;
                                        });
                                        FocusScope.of(context).requestFocus(f9);
                                      } else {
                                        setState(() {
                                          countryValidate = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),


              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * .08,
                      left: MediaQuery.of(context).size.width * .05,
                      right: MediaQuery.of(context).size.width * .05,
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: ScreenColors().yellowColor.withOpacity(.8),
                      ),
                      child: RaisedButton(
                        onPressed: () async {

                          validate();
                          update(name.text,email.text,adress.text,city.text,country.text);

                        },
                        color: ScreenColors().yellowColor.withOpacity(.8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                         Language=="en"? 'Continue':'استمر',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> update(String f_Name, String email, String country, String city, String adress) async {
    if(validate()){
      profile=await updateProfile(widget.userId,f_Name,email,widget.mobile,country,city,adress);
      if(profile.message=="profile updated successfully"){
      saveToStorage(profile.user[0].userId,profile.user[0].fName,profile.user[0].email, profile.user[0].mobile, profile.user[0].country,profile.user[0].city, profile.user[0].address);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ImagePickerScreen()));
      }
    }
    else{
    }
  }

  bool validate() {
    /////////////////////////////////////////////////////////////
    if (name.text.isEmpty) {
      setState(() {
        nameValidate = true;
        FocusScope.of(context).requestFocus(f1);
      });
    } else if (name.text.isNotEmpty) {
      setState(() {
        nameValidate = false;
      });

      f1.unfocus();
    }
    ////////////////////////////////////////////////////////////
    if (email.text.isEmpty) {
      setState(() {
        emailValidate = true;
        FocusScope.of(context).requestFocus(f2);
      });
    } else if (email.text.isNotEmpty) {
      setState(() {
        emailValidate = false;
      });
      f2.unfocus();
    }

    ////////////////////////////////////////////////////////////
    if (adress.text.isEmpty) {
      setState(() {
        adressValidate = true;
        FocusScope.of(context).requestFocus(f4);
      });
    } else {
      adressValidate = false;
      f4.unfocus();
    }
    ////////////////////////////////////////////////////////////
    if (zip.text.isEmpty) {
      setState(() {
        zipValidate = true;
        FocusScope.of(context).requestFocus(f6);
      });
    } else {
      zipValidate = false;
      f6.unfocus();
    }
    ////////////////////////////////////////////////////////////
    if (city.text.isEmpty) {
      setState(() {
        cityValidate = true;
        FocusScope.of(context).requestFocus(f7);
      });
    } else {
      cityValidate = false;
      f7.unfocus();
    }
    ////////////////////////////////////////////////////////////
    if (state.text.isEmpty) {
      setState(() {
        stateValidate = true;
        FocusScope.of(context).requestFocus(f8);
      });
    } else {
      stateValidate = false;
      f8.unfocus();
    }
    ////////////////////////////////////////////////////////////
    if (country.text.isEmpty) {
      setState(() {
        countryValidate = true;
        FocusScope.of(context).requestFocus(f9);
      });
    } else {
      countryValidate = false;
      f9.unfocus();
    }////////////////////////////////////////////////////////////
    if(name.text.isNotEmpty && email.text.isNotEmpty &&

       adress.text.isNotEmpty && zip.text.isNotEmpty && city.text.isNotEmpty && state.text.isNotEmpty && country.text.isNotEmpty ){
      return true;
    }
    else{
      return false;
    }
  }

  Future<void> saveToStorage(int userIdddd,String fName, String email, String mobile, String country, String city, String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.setInt('userId', userIdddd);
    prefs.setString('firstName', fName);
    prefs.setString('email', email);
    prefs.setString('mobile', mobile);
    prefs.setString('country', country);
    prefs.setString('city', city);
    prefs.setString('address', address);
    prefs.setString('login', "true");
  }

  Future<void> saveIDandPhone(int UID,String Number) async {
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(Number!=null){
      print("***************");
      prefs.setInt('userId', UID);
      prefs.setString('mobile', Number);
    }
  }
  showAlertDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      backgroundColor: ScreenColors().blackColor,
      content: new Row(
        children: [
          CircularProgressIndicator(
            backgroundColor: ScreenColors().yellowColor,

          ),
          Container(margin: EdgeInsets.only(left: 5),child:Text("Loading" , style: TextStyle(
              color: ScreenColors().yellowColor
          ),)),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}
