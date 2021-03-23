import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:fotodio/Models/submitImageModel.dart';
import 'package:fotodio/Screens/PlaceOrderScreen.dart';
import 'package:fotodio/Screens/imageeditor.dart';
import 'package:fotodio/Screens/modelclasses/sponsorimagesresponse.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:fotodio/Screens/colors.dart';
import 'package:fotodio/Screens/modelclasses/extension.dart';
import 'package:fotodio/Screens/notificationScreen.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fotodio/Screens/LoginProfile.dart';
import 'package:fotodio/Screens/splashScreen.dart';
import 'package:fotodio/Models/SizeModel.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:io';

import 'dart:convert';

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

///-------------------------------------------------------------------
Future<SponsorImage> fetchSponsorImages() async {
  final String apiUrl = "http://fotod.io/api/sponsorimage";
  final response = await http.post(apiUrl, body: {});
  print(response.statusCode);

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return SponsorImage.fromRawJson(responseString);
  } else {
    return null;
  }
}



class _ImagePickerScreenState extends State<ImagePickerScreen> {
  static GlobalKey screen = new GlobalKey();
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List _imageFile;
  capture(){
    screenshotController
        .capture()
        .then((Uint8List image) async {
      //print("Capture Done");
      setState(() {
        _imageFile = image;
      });
      var screenshotFile = await ImagePickerSaver.saveFile( fileData: _imageFile);
      var savedFile= File.fromUri(Uri.file(screenshotFile));
      print(savedFile.path);



  }
  );
        }

  //Create an instance of ScreenshotController

  File testing;
  List path=[];
  List pathName=[];
  String Language;
  void fetchLaguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var lan= prefs.getString("language");
    setState(() {
      Language=lan;
    });

  }
  int userid;
  String uuid;
  String Fullname = "xyz";
  String Email = "xyz";
  String Phone = "xyz";
  String Country = "xyz";
  String City = "xyz";
  String Adress = "xyz";
  SumitImageModel _data;
  int index;
  bool selected = false;
  int selectedPicture;
  SponsorImage data1;
  List<String> base64Array =[];

  void initState() {
    pathName.clear();
    path.clear();
    fetchData();
    fetchStorageData();
    fetchLaguage();
    super.initState();
    print(Fullname);

  }





  List<Size> data2;

  int _currentIndex = 0;
  List<Asset> images = List<Asset>();
  List files = [];
  String _error = 'No Error Dectected';
  String imageBase64 = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: InnerDrawer(
              key: _innerDrawerKey,
              onTapClose: true,
              // default false
              swipe: true,
              // default true
              colorTransitionChild: Colors.black.withOpacity(.5),
              // default Color.black54
              colorTransitionScaffold: Colors.black54,
              // default Color.black54

              //When setting the vertical offset, be sure to use only top or bottom
              offset: IDOffset.only(bottom: 0.05, right: 0.0, left: 0.0),
              scale: IDOffset.horizontal(0.8),
              // set the offset in both directions

              proportionalChildArea: true,
              // default true
              borderRadius: 50,
              // default 0
              leftAnimationType: InnerDrawerAnimation.static,
              // default static
              rightAnimationType: InnerDrawerAnimation.quadratic,
              backgroundDecoration:
                  BoxDecoration(color: Colors.black.withOpacity(.9)),
              // default  Theme.of(context).backgroundColor

              //when a pointer that is in contact with the screen and moves to the right or left
              onDragUpdate: (double val, InnerDrawerDirection direction) {
                // return values between 1 and 0
                print(val);
                // check if the swipe is to the right or to the left
                print(direction == InnerDrawerDirection.start);
              },
              innerDrawerCallback: (a) => print(a),
              // return  true (open) or false (close)
              leftChild: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .15,
                  bottom: MediaQuery.of(context).size.height * .06,
                  left: MediaQuery.of(context).size.width * .05,
                  right: MediaQuery.of(context).size.width * .05,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.black,
                    border: Border.all(
                      width: 1.0,
                      color: ScreenColors().yellowColor,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ScreenColors().yellowColor.withOpacity(.8),
                        offset: Offset(0, 3.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .07),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          Fullname,
                          style: TextStyle(color: ScreenColors().yellowColor),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .007,
                        ),
                        Text(
                          Phone,
                          style: TextStyle(color: ScreenColors().yellowColor),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .007,
                        ),
                        Text(
                          City,
                          style: TextStyle(color: ScreenColors().yellowColor),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .007,
                        ),
                        Text(
                          Country,
                          style: TextStyle(color: ScreenColors().yellowColor),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .09,
                              left: MediaQuery.of(context).size.width * .02,
                              right: MediaQuery.of(context).size.width * .01),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.circle_notifications,
                                    color: ScreenColors().yellowColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => NotificationScreen()));
                                    },
                                    child: Text(
                                      Language=="en"?"Notication":"تنبيه",
                                      style: TextStyle(
                                          color: ScreenColors().yellowColor),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .02,
                              left: MediaQuery.of(context).size.width * .02,
                              right: MediaQuery.of(context).size.width * .01),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.perm_identity,
                                    color: ScreenColors().yellowColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: InkWell(
                                    child: Text(
                                      Language=="en"?"Update Profile":"تحديث الملف",
                                      style: TextStyle(
                                          color: ScreenColors().yellowColor),
                                    ),
                                    onTap: ()  {
                                      fetchStorageData();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginProfile(Phone,userid)));
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .02,
                              left: MediaQuery.of(context).size.width * .02,
                              right: MediaQuery.of(context).size.width * .01),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.language,
                                    color: ScreenColors().yellowColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: DropdownButton<String>(
                                    iconDisabledColor: ScreenColors().yellowColor,
                                    iconEnabledColor:ScreenColors().yellowColor ,

                                    dropdownColor: ScreenColors().blackColor,
                                    hint: Center(
                                      child: Text(Language=="en"?"Language":"لغة", style: TextStyle(
                                        color: ScreenColors().yellowColor
                                      ),),
                                    ),
                                    items: <String>['English', "عربي"].map((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value, style: TextStyle(
                                          color: ScreenColors().yellowColor,
                                          backgroundColor: ScreenColors().blackColor
                                        ),),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                        print(value);
                                        changeLanguage(value);
                                    },
                                  )
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .02,
                              left: MediaQuery.of(context).size.width * .02,
                              right: MediaQuery.of(context).size.width * .01),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.logout,
                                    color: ScreenColors().yellowColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: InkWell(
                                    child: Text(
                                      Language=="en"?"LogOut":"تسجيل خروج",
                                      style: TextStyle(
                                          color: ScreenColors().yellowColor),
                                    ),
                                    onTap: () async{


                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                     prefs.setString('login',"false");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SplashScreen()));

                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // required if rightChild is not set
              rightChild: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .15,
                  bottom: MediaQuery.of(context).size.height * .06,
                  left: MediaQuery.of(context).size.width * .05,
                  right: MediaQuery.of(context).size.width * .05,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.black,
                    border: Border.all(
                      width: 1.0,
                      color: ScreenColors().yellowColor,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ScreenColors().yellowColor.withOpacity(.8),
                        offset: Offset(0, 3.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .07),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          Fullname,
                          style: TextStyle(color: ScreenColors().yellowColor),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .007,
                        ),
                        Text(
                          Phone,
                          style: TextStyle(color: ScreenColors().yellowColor),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .007,
                        ),
                        Text(
                          City,
                          style: TextStyle(color: ScreenColors().yellowColor),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .007,
                        ),
                        Text(
                          Country,
                          style: TextStyle(color: ScreenColors().yellowColor),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .1,
                              left: MediaQuery.of(context).size.width * .02,
                              right: MediaQuery.of(context).size.width * .01),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.circle_notifications,
                                    color: ScreenColors().yellowColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => NotificationScreen()));
                                    },
                                    child: Text(
                                      Language=="en"?"Notication":"تنبيه",
                                      style: TextStyle(
                                          color: ScreenColors().yellowColor),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .02,
                              left: MediaQuery.of(context).size.width * .02,
                              right: MediaQuery.of(context).size.width * .01),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.perm_identity,
                                    color: ScreenColors().yellowColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: InkWell(
                                    child: Text(
                                      Language=="en"?"Update Profile":"تحديث الملف",
                                      style: TextStyle(
                                          color: ScreenColors().yellowColor),
                                    ),
                                    onTap: () {
                                      fetchStorageData();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginProfile(Phone,userid)));
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .02,
                              left: MediaQuery.of(context).size.width * .02,
                              right: MediaQuery.of(context).size.width * .01),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.language,
                                    color: ScreenColors().yellowColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: DropdownButton<String>(
                                      iconDisabledColor: ScreenColors().yellowColor,
                                      iconEnabledColor:ScreenColors().yellowColor ,

                                      dropdownColor: ScreenColors().blackColor,
                                      hint: Center(
                                        child: Text(Language=="en"?"Language":"لغة", style: TextStyle(
                                            color: ScreenColors().yellowColor
                                        ),),
                                      ),
                                      items: <String>['English', "عربي"].map((String value) {
                                        return new DropdownMenuItem<String>(
                                          value: value,
                                          child: new Text(value, style: TextStyle(
                                              color: ScreenColors().yellowColor,
                                              backgroundColor: ScreenColors().blackColor
                                          ),),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        print(value);
                                        changeLanguage(value);
                                      },
                                    )
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .02,
                              left: MediaQuery.of(context).size.width * .02,
                              right: MediaQuery.of(context).size.width * .01),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.logout,
                                    color: ScreenColors().yellowColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: InkWell(
                                    onTap: () async {
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setString('login',"false");
                                      Navigator.push(
                                          context, MaterialPageRoute(builder: (context) => SplashScreen()));
                                    },
                                    child: Text(
                                      Language=="en"?"LogOut":"تسجيل خروج",
                                      style: TextStyle(
                                          color: ScreenColors().yellowColor),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // required if leftChild is not set

              //  A Scaffold is generally used but you are free to use other widgets
              // Note: use "automaticallyImplyLeading: false" if you do not personalize "leading" of Bar
              scaffold: Scaffold(
                backgroundColor: ScreenColors().blackColor,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: ScreenColors().yellowColor,
                  title: Text("Fotodio"),
                  centerTitle: true,
                ),
                body: Container(
                    height: MediaQuery.of(context).size.height * 0.999,
                    width: double.infinity,
                    decoration: BoxDecoration(
//color: Color(0xffFF245E),

                        ),
                    child: Center(
                      child: ListView(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 100,
                            height: MediaQuery.of(context).size.height * .35,
                           //color: Colors.red,
                            child:
                            FutureBuilder(
                              future: fetchData(),
                              builder: (context, snapshot){
                               if(snapshot.hasData){
                                return ListView.builder(
                                     scrollDirection: Axis.horizontal,
                                     itemCount: data1.data.length,
                                     itemBuilder: (BuildContext context, index) {
                                       return Padding(
                                         padding: EdgeInsets.all(20),
                                         child: GestureDetector(
                                           child: Container(
                                             width:
                                             MediaQuery.of(context).size.width *
                                                 .8,
                                             height:
                                             MediaQuery.of(context).size.height *
                                                 100,
                                             decoration: BoxDecoration(
                                               borderRadius:
                                               BorderRadius.circular(20.0),
                                               color: Colors.black,
                                               border: Border.all(
                                                 width: 1.0,
                                                 color: ScreenColors().yellowColor,
                                               ),
                                               boxShadow: [
                                                 BoxShadow(
                                                   color: ScreenColors()
                                                       .yellowColor
                                                       .withOpacity(.8),
                                                   offset: Offset(0, 3.0),
                                                   blurRadius: 6.0,
                                                 ),
                                               ],
                                             ),
                                             child:ClipRRect(
                                               borderRadius: BorderRadius.circular(20.0),
                                               child: Image.network(
                                                 data1.data[index].imagepath, fit: BoxFit.fill,),
                                             )


                                           ),
                                           onTap: () {
                                             showDialog(
                                                 index,
                                                 data1.data[index].imagepath,
                                                 data1.data[index].sponsor,
                                                 data1.data[index].totalsponsored,
                                                 data1.data[index].imgSize);
                                           },
                                         ),
                                       );
                                     }
                                 );
                               }
                               else{
                                 return  Center(child: CircularProgressIndicator() );
                              }
                              },
                            ),


                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              width: MediaQuery.of(context).size.width * 50,
                              height: MediaQuery.of(context).size.height * .30,
//color: Colors.red,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: path.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Container(
//                                        width:
//                                            MediaQuery.of(context).size.width *
//                                                .37,
//                                        height:
//                                            MediaQuery.of(context).size.height *
//                                                60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          color: Colors.white,
                                          border: Border.all(
                                            width: 1.0,
                                            color: ScreenColors().yellowColor,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: ScreenColors()
                                                  .yellowColor
                                                  .withOpacity(.8),
                                              offset: Offset(0, 3.0),
                                              blurRadius: 6.0,
                                            ),
                                          ],
                                        ),

//                                            ),
                                        child:
                                        index==0?Center(
                                          child: Screenshot(
                                            controller: screenshotController,
                                            child: Stack(
                                                children: [
                                                  Center(
                                                    child: Container(
                                                      decoration:BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                        child: Image.file(File(path[index]),
                                                          fit: BoxFit.cover,),
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Align(
                                                        alignment:Alignment.bottomCenter,
                                                        child: Padding(
                                                            padding:EdgeInsets.only(left: 5),
                                                            child: Container(
                                                              width: MediaQuery.of(context).size.width*.1,
                                                              height: MediaQuery.of(context).size.width*.1,
                                                              child: selected==true?Image.network(data1.data[selectedPicture].imagepath):Text(" "),
                                                            )
                                                        )
                                                    ),
                                                  )
                                                ]
                                            ),
                                          ),
                                        ):Center(
                                          child:Stack(
                                              children: [
                                                Center(
                                                  child: Container(
                                                    decoration:BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      child: Image.file(File(path[index]),
                                                        fit: BoxFit.cover,),
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Align(
                                                      alignment:Alignment.bottomCenter,
                                                      child: Padding(
                                                          padding:EdgeInsets.only(left: 5),
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width*.1,
                                                            height: MediaQuery.of(context).size.width*.1,
                                                            child: selected==true?Image.network(data1.data[selectedPicture].imagepath):Text(" "),
                                                          )
                                                      )
                                                  ),
                                                )
                                              ]
                                          ),
                                        )
                                      ),
                                    );
                                  }),
                            ),
//                                    child: Assetxb(
//                                        asset: images[index],
//                                        width: 400,
//                                        height: 400
//                                    ),
                          )
                        ],
                      ),
                    )),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    _toggle();
                    // Add your onPressed code here!
                  },
                  child: Icon(Icons.menu),
                  backgroundColor: ScreenColors().yellowColor,
                  splashColor: ScreenColors().yellowColor,
                ),
                bottomNavigationBar: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  width: MediaQuery.of(context).size.width * 100,
                  height: MediaQuery.of(context).size.height * .08,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.black,
                    boxShadow: [
                      BoxShadow(
                        color: ScreenColors().yellowColor.withOpacity(.8),
                        offset: Offset(3, -1),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: ()  async{
                            loadAssets();
                            _submit();
                          },
                          child: Icon(
                            Icons.collections,
                            color: ScreenColors().yellowColor,
                            size: MediaQuery.of(context).size.width * .1,
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            if (images.length > 0) {
                              if (selected == false) {
                                _submit();
                           Navigator.push(
                                   context,
                                   MaterialPageRoute(builder: (context) => ImageSelection(images, files,path,pathName)));


                              } else if (selected == true) {
                                capture();
                                _submit();

                                var avaialbe = double.parse(data1.data[selectedPicture].totalsponsored);
                                int totalAvailable=avaialbe.round();
                                if(images.length>totalAvailable){
                                errorSelection();
                                }

                                else{
                                  int min = 10000; //min and max values act as your 6 digit range
                                  int max = 99999;
                                  var randomizer = new Random();
                                  var rNum = min + randomizer.nextInt(max - min);
                                  var princeIndouble = double.parse(data1.data[selectedPicture].discount);
                                  int price=princeIndouble.round();
                                  int totalPrice=price*images.length;
                                  print("____________________________________________________________________");
                                  print(userid);
                                  print(rNum);
                                  print(totalPrice);
//                                  var long2 = double.parse(_size.deliverycharges[0].deliveryCharges);
//                                  var delieveryCharges=long2.round();
                                  submitPicture(rNum.toString(), userid,totalPrice, 0);
                                }

                              }
                            } else {
                              errorDialog();
                            }
                          },
                          child: Icon(
                            Icons.cloud_upload,
                            color: ScreenColors().yellowColor,
                            size: MediaQuery.of(context).size.width * .1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              ),
        ),
      ),
    );
  }

  //  Current State of InnerDrawerState
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  void _toggle() {
    _innerDrawerKey.currentState.toggle(
        // direction is optional
        // if not set, the last direction will be used
        //InnerDrawerDirection.start OR InnerDrawerDirection.end
        direction: InnerDrawerDirection.end);
  }

  errorDialog() {
    return Dialogs.materialDialog(
        color: Colors.black,
        msg: Language=="en"?'Please Select Some Images First':"الرجاء تحديد بعض الصور أولاً",
        msgStyle: TextStyle(color: Colors.red),
        context: context,
        actions: [
          IconsButton(
            onPressed: () {
              Navigator.pop(context);
            },
            text: Language=="en"?'OK':'حسنا',
            iconData: Icons.done,
            color: ScreenColors().yellowColor,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }

  errorSelection() {
    return Dialogs.materialDialog(
        color: Colors.black,
        msg: Language=="en"?'You cannot select picture more than total sponsor images':"لا يمكنك اختيار صورة أكثر من مجموع صور الراعي",
        msgStyle: TextStyle(color: Colors.red),
        context: context,
        actions: [
          IconsButton(
            onPressed: () {
              Navigator.pop(context);
            },
            text: Language=="en"?'OK':'حسنا',
            iconData: Icons.done,
            color: ScreenColors().yellowColor,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }

  showDialog(
      int selectedIndex, var path, var sponsor, var totalSponsor, var imgSize) {
    return Dialogs.bottomMaterialDialog(
        color: Colors.black,
        msg: 'Total Sponsor Images    $totalSponsor\n\n '
            "Sponsor Image Size       $imgSize\n",
        msgStyle: TextStyle(color: ScreenColors().yellowColor),
        title: sponsor,
        titleStyle: TextStyle(color: ScreenColors().yellowColor),
        context: context,
        actions: [
          IconsButton(
            onPressed: () {
              selected = false;
              Navigator.pop(context);
            },
            text: Language=="en"?'Cancel':'إلغاء',
            color: Colors.red,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
          IconsButton(
            onPressed: () {
              setState(() {
                selected = true;
                selectedPicture = selectedIndex;
                Navigator.pop(context);
              });
            },
            text: Language=="en"?'Continue':'استمر',
            color: ScreenColors().yellowColor,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]
    );
  }

  Future<void> loadAssets() async {
    path.clear();
    images.clear();
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: true,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
    _submit();
  }
  _submit() async {
path.clear();
    var myfile;
    for (int i = 0; i < images.length; i++) {
      var path2 =
          await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      var file = await getImageFileFromAsset(path2);
     path.add(file.path);
     pathName.add(file.name);
    myfile=new File(pathName.toString());
      var base64Image = base64Encode(file.readAsBytesSync());
      base64Array.add(base64Image.toString());
      files.add(base64Image);
       var data = {
        "files": files,
      };
    }
    setState(() {

    });
  }
  Future<File> getImageFileFromAsset(String path) async {
    var file = File(path);
    return file;
  }

  Future<void> fetchData() async {
   data1 = await fetchSponsorImages();

   return data1;
  }

    Future<SumitImageModel> submitPicture(String orderCode, int userID, int totalBill, int delieveryCharges) async {
      /////////////////////////////////////////////////////////////////////////////////////
      if(images.length==1) {


        print("length---------------------------------1");
        print(userID);
        print(orderCode);
        print(data1.data[selectedPicture].id.toString());
        print(data1.data[selectedPicture].imgSize.toString());
        Map<String, String> headers = { "Content-Type": "multipart/form-data"};
        var request = http.MultipartRequest(
            'POST', Uri.parse('http://fotod.io/api/picturesubmit'));

        request.fields.addAll({
          'customerID': userID.toString(),
          'ordercode': orderCode,
          'pic1qty': "1",
          'pic1size':"0",
          'sponsorID':data1.data[selectedPicture].id.toString(),
          'imagesize':data1.data[selectedPicture].imgSize.toString()
        });

        request.files.add(await http.MultipartFile.fromPath('pic1', path[0]));
        request.headers["Content-Type"]="multipart/form-data";
        showAlertDialog(context);
        http.StreamedResponse response = await request.send();
        Navigator.pop(context);

        if (response.statusCode == 200) {
          print(await response.stream.bytesToString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlaceOrderScreen(totalBill, orderCode, userID.toString(), delieveryCharges)));
        }
        else {
          print(response.reasonPhrase);
        }
      }

//  ////////////////////////////////////////////2222222222///////////////////////////////////////////////////////////////////////
      if(images.length==2){
        print("length---------------------------------2");

        Map<String, String> headers = { "Content-Type": "multipart/form-data"};
        var request = http.MultipartRequest(
            'POST', Uri.parse('http://fotod.io/api/picturesubmit'));

        request.fields.addAll({
          'customerID': userID.toString(),
          'ordercode': orderCode,
          'pic1qty': "1",
          'pic1size': "0",
          'pic2qty': "1",
          'pic2size':"0",
          'sponsorID':data1.data[selectedPicture].id.toString(),
          'imagesize':data1.data[selectedPicture].imgSize.toString()

        });

        request.files.add(await http.MultipartFile.fromPath('pic1', path[0]));
        request.files.add(await http.MultipartFile.fromPath('pic2', path[1]));
        request.headers["Content-Type"] = "multipart/form-data";
        showAlertDialog(context);
        http.StreamedResponse response = await request.send();
        Navigator.pop(context);
        if (response.statusCode == 200) {
          print(await response.stream.bytesToString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlaceOrderScreen(totalBill,orderCode, userID.toString(), delieveryCharges)));
        }
        else {
          print(response.reasonPhrase);
        }
      }
// ////////////////////////////////////////////333333333333333333///////////////////////////////////////////////////////////////////////
      if(images.length==3){
        print("length---------------------------------3");
        var request = http.MultipartRequest(
            'POST', Uri.parse('http://fotod.io/api/picturesubmit'));
        request.fields.addAll({
          'customerID': userID.toString(),
          'ordercode': orderCode,
          'pic1qty': "1",
          'pic1size':"0",
          'pic2qty': "1",
          'pic2size': "0",
          'pic3qty': "1",
          'pic3size': "0",
          'sponsorID':data1.data[selectedPicture].id.toString(),
          'imagesize':data1.data[selectedPicture].imgSize.toString()
        });
        request.files.add(await http.MultipartFile.fromPath('pic1', path[0]));
        request.files.add(await http.MultipartFile.fromPath('pic2', path[1]));
        request.files.add(await http.MultipartFile.fromPath('pic3', path[2]));
        request.headers["Content-Type"] = "multipart/form-data";
        showAlertDialog(context);
        http.StreamedResponse response = await request.send();
        Navigator.pop(context);
        if (response.statusCode == 200) {
          print(await response.stream.bytesToString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlaceOrderScreen(totalBill,orderCode, userID.toString(),delieveryCharges)));
        }
        else {
          print(response.reasonPhrase);
        }
      }
// ////////////////////////////////////////////4444444444444444444444444///////////////////////////////////////////////////////////////////////
      if(images.length==4){
        print("length---------------------------------4");
        var request = http.MultipartRequest(
            'POST', Uri.parse('http://fotod.io/api/picturesubmit'));

        request.fields.addAll({
          'customerID': userID.toString(),
          'ordercode': orderCode,
          'pic1qty': "1",
          'pic1size': "0",
          'pic2qty': "1",
          'pic2size': "0",
          'pic3qty': "1",
          'pic3size':"0",
          'pic4qty':"1",
          'pic4size':"0",
          'sponsorID':data1.data[selectedPicture].id.toString(),
          'imagesize':data1.data[selectedPicture].imgSize.toString()
        });

        request.files.add(await http.MultipartFile.fromPath('pic1', path[0]));
        request.files.add(await http.MultipartFile.fromPath('pic2', path[1]));
        request.files.add(await http.MultipartFile.fromPath('pic3', path[2]));
        request.files.add(await http.MultipartFile.fromPath('pic4', path[3]));
        request.headers["Content-Type"] = "multipart/form-data";
        showAlertDialog(context);
        http.StreamedResponse response = await request.send();
        Navigator.pop(context);

        if (response.statusCode == 200) {
          print(await response.stream.bytesToString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlaceOrderScreen(totalBill,orderCode, userID.toString(),delieveryCharges)));
        }
        else {
          print(response.reasonPhrase);
        }
      }
// ////////////////////////////////////////////555555555555555555555///////////////////////////////////////////////////////////////////////
      if(images.length==5){
        print("length---------------------------------5");
        var request = http.MultipartRequest(
            'POST', Uri.parse('http://fotod.io/api/picturesubmit'));
        request.fields.addAll({
          'customerID': userID.toString(),
          'ordercode': orderCode,
          'pic1qty': "1",
          'pic1size': "0",
          'pic2qty': "1",
          'pic2size': "0",
          'pic3qty': "1",
          'pic3size':"0",
          'pic4qty': "1",
          'pic4size':"0",
          'pic5qty': "1",
          'pic5size': "0",
          'sponsorID':data1.data[selectedPicture].id.toString(),
          'imagesize':data1.data[selectedPicture].imgSize.toString()
        });

        request.files.add(await http.MultipartFile.fromPath('pic1', path[0]));
        request.files.add(await http.MultipartFile.fromPath('pic2', path[1]));
        request.files.add(await http.MultipartFile.fromPath('pic3', path[2]));
        request.files.add(await http.MultipartFile.fromPath('pic4', path[3]));
        request.files.add(await http.MultipartFile.fromPath('pic5', path[4]));
        request.headers["Content-Type"] = "multipart/form-data";
        showAlertDialog(context);
        http.StreamedResponse response = await request.send();
        Navigator.pop(context);

        if (response.statusCode == 200) {
          print(await response.stream.bytesToString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlaceOrderScreen(totalBill,orderCode, userID.toString(), delieveryCharges)));
        }
        else {
          print(response.reasonPhrase);
        }
      }
      ///////////////////////////////////////////////////////////////////////////
  }
  Future<void> fetchStorageData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId=prefs.getInt('userId');
    var name = prefs.getString('firstName');
    var email = prefs.getString('email');
    var mobile = prefs.getString('mobile');
    var country = prefs.getString('country');
    var city = prefs.getString('city');
    var address = prefs.getString('address');
    print(name);
    print(mobile);
    setState(() {
      userid=userId;
      Fullname = name;
      Email = email;
      Phone = mobile;
      Country = country;
      City = city;
      Adress = address;
      userid=userId;
    });
    print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    print(Fullname);
  }
  void changeLanguage(String Language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(Language=="English"){
      prefs.setString("language", "en");
      fetchLaguage();
    }
    else{
      prefs.setString("language", "ar");
      fetchLaguage();
    }
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



//Future<void> submitMultiPart() async {
//  var formData = FormData();
//  FormData.fromMap({
//    "customerID":"123",
//    "ordercode":"456",
//    "pic1": await MultipartFile.fromFile(path[0],
//      filename: pathName[0].toString(),
//      contentType: MediaType('jpg', 'png',),
//    ),
//    "pic1qty":1,
//    "pic1size":1
//
//  });
//  Dio dio = new Dio();
//  final response = await dio.post("http://fotod.io/api/picturesubmit", data: formData);
//  print(response.statusCode);
//  print(response.data);
//}
