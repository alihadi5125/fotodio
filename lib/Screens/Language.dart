import 'package:flutter/material.dart';
import 'package:fotodio/Screens/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fotodio/Screens/onBordingScreen.dart';
class Language extends StatefulWidget {
  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width*100,
          height: MediaQuery.of(context).size.width*100,
          color: ScreenColors().blackColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Select Language", style: TextStyle(
                color: ScreenColors().yellowColor,
                fontSize: 30
              ),),
              SizedBox(height:20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RaisedButton(
                    color: ScreenColors().yellowColor,
                    child: Text(
                        "English"
                    ),
                    onPressed: (){
                      changeLanguage("en");
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => onBoardingScreen()));
                    },
                  ),
                  SizedBox(width:20),
                  RaisedButton(
                    color: ScreenColors().yellowColor,
                    child: Text(
                        "Arabic"
                    ),
                    onPressed: (){
                      changeLanguage("ar");
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => onBoardingScreen()));
                    },
                  )
                ],
              ),
            ],
          )
        ),
      ),
    );
  }

  void changeLanguage(String Language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("language", Language);
  }
}

