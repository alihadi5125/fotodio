import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fotodio/Models/SizeModel.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:fotodio/Screens/colors.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:fotodio/Screens/PlaceOrderScreen.dart';




class ImageSelection extends StatefulWidget {
  List<Asset> images = List<Asset>();
  List files =List();
  List path=[];
  List pathName=[];
  ImageSelection(this.images, this.files,this.path,this.pathName);

  @override
  _ImageSelectionState createState() =>
      _ImageSelectionState(this.images, this.files, this.path, this.pathName);
}



class _ImageSelectionState extends State<ImageSelection> {
  Future<SizeModel> showSizes(int id) async {
    print("000000000000000000000000000000000000000000000000000000000000000000000000");
    print(id);
    final String apiUrl = "http://fotod.io/api/pricesize";
    final response = await http.post(apiUrl, body: {
      "userID" : id.toString()
    });

    if (response.statusCode == 200) {
      print(response.statusCode);
      final String responseString = response.body;
      print(responseString);

      return SizeModel.fromRawJson(responseString);
    } else {
      return null;
    }
  }
  SizeModel sizes;
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
  String orderCode;
  List<String> selectedImageSize1 = [];
  List<int> selectedCount1 = [];
  List<String> selectedImageSize2 = [];
  List<int> selectedCount2 = [];
  List<String> selectedImageSize3 = [];
  List<int> selectedCount3 = [];
  List<String> selectedImageSize4 = [];
  List<int> selectedCount4 = [];
  List<String> selectedImageSize5 = [];
  List<int> selectedCount5 = [];

  List<int> _itemCount1 = [];
  List<int> _itemCount2 = [];
  List<int> _itemCount3 = [];
  List<int> _itemCount4 = [];
  List<int> _itemCount5 = [];

  List<bool> dialogChecked1 = [];
  List<bool> dialogChecked2 = [];
  List<bool> dialogChecked3 = [];
  List<bool> dialogChecked4 = [];
  List<bool> dialogChecked5 = [];
  int UserId;
  SizeModel _sizes;
  List<Asset> images = List<Asset>();
  List files =[];
  List<String> imageSizes = [];
  _ImageSelectionState(this.images, this.files, this.path,this.pathName);

  @override
  void initState() {
    print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    super.initState();

    fetchLaguage();

    print(UserId);
    print("---------------------------------------------------------------------------------------");
    imageSizes.clear();
    dialogChecked1.clear();
    dialogChecked2.clear();
    dialogChecked3.clear();
    dialogChecked4.clear();
    dialogChecked5.clear();
    _itemCount1.clear();
    _itemCount2.clear();
    _itemCount3.clear();
    _itemCount4.clear();
    _itemCount5.clear();

    selectedImageSize1.clear();
    selectedCount1.clear();

    selectedImageSize2.clear();
    selectedCount2.clear();

    selectedImageSize3.clear();
    selectedCount3.clear();

    selectedImageSize4.clear();
    selectedCount4.clear();

    selectedImageSize5.clear();
    selectedCount5.clear();
    fetchStorageData();

  }
  Future<void> fetchStorageData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId=prefs.getInt('userId');
    print("ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ");
    print(userId);
    setState(() {
      UserId=userId;
    });
    fetchSize(userId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ScreenColors().blackColor,
      appBar: AppBar(
          backgroundColor: ScreenColors().yellowColor,
          title: Center(
            child: Text(Language=="en"?"Images Selection":"تحديد الصور"),
          ),
          leading: InkWell(
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 25,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )),
      body: FutureBuilder(
        future: null,
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: images.length,
            itemBuilder: (BuildContext context, index) {
              Asset asset = images[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: MediaQuery.of(context).size.height * .03,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.black,
                    border: Border.all(
                      width: 1.0,
                      color: ScreenColors().yellowColor,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ScreenColors().yellowColor.withOpacity(.7),
                        offset: Offset(0, 3.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image.file(File(path[index]),
                          fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(18),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (index == 0) {
                                          if (imageSizes.length != 0) {
                                            __dialog1();
                                          }
                                        } else if (index == 1) {
                                          if (imageSizes.length != 0) {
                                            __dialog2();
                                          }
                                        } else if (index == 2) {
                                          if (imageSizes.length != 0) {
                                            __dialog3();
                                          }
                                        } else if (index == 3) {
                                          if (imageSizes.length != 0) {
                                            __dialog4();
                                          }
                                        } else if (index == 4) {
                                          if (imageSizes.length != 0) {
                                            __dialog5();
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(12.0),
                                          color: ScreenColors().yellowColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            Language=="en"?"Select Size":"أختر الحجم",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 10,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.06,
            decoration: BoxDecoration(
              color: Colors.pink.withOpacity(0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: RaisedButton(
              color: ScreenColors().yellowColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              onPressed: (){
                print("printingggggggggggggggggggggggggggggggggggggggggggggggg");
                print(UserId.toString());
                int totalSum=0;
                int min = 10000; //min and max values act as your 6 digit range
                int max = 99999;
                var randomizer = new Random();
                var rNum = min + randomizer.nextInt(max - min);

                  int sum1=totalBill1();
                  int sum2=totalBill2();
                  int sum3=totalBill3();
                  int sum4=totalBill4();
                  int sum5=totalBill5();
                  totalSum=sum1+sum2+sum3+sum4+sum5;
                totalSum=totalBill1()+totalBill2()+totalBill3()+totalBill4()+totalBill5();
                print(totalSum);
                print("delievery charges");
                print(_sizes.deliverycharges[0].deliveryCharges);
                var long2 = double.parse(_sizes.deliverycharges[0].deliveryCharges);
                var delieveryCharges=long2.round();



             if(totalSum!=0){
             submitMultiPart(UserId.toString(),totalSum,rNum.toString(), delieveryCharges);
             }
             else{
               Fluttertoast.showToast(
                   msg: "Please Select Some Size First",
                   toastLength: Toast.LENGTH_SHORT,
                   gravity: ToastGravity.CENTER,
                   timeInSecForIosWeb: 1,
                   backgroundColor:ScreenColors().blackColor,
                   textColor: ScreenColors().yellowColor,
                   fontSize: 16.0
               );
             }
              },
              child: Text(
                Language=="en"?'Proceed to Payment':'الشروع في دفع',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          )),
    ));
  }
  /// first dialog
  void __dialog1() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15)),
                child: Container(
                  height: MediaQuery.of(context).size.height * .5,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10.0),
                            ),
                            color: ScreenColors().yellowColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.16),
                                offset: Offset(0, 3.0),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              Language=="en"?"Select Size and Quantity":"حدد الحجم والكمية",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * .05),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          color: ScreenColors().blackColor,
                          child: Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * .02),
                            child: ListView.builder(
                              itemCount: imageSizes.length,
                              itemBuilder: (context, index) {
                                if(imageSizes.length>0){
                                  return Container(
                                    margin: EdgeInsets.only(
                                        bottom:
                                        MediaQuery.of(context).size.width *
                                            .02),
                                    width:
                                    MediaQuery.of(context).size.width * 100,
                                    height:
                                    MediaQuery.of(context).size.width * .20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.black,
                                      border: Border.all(
                                        width: 1.0,
                                        color: ScreenColors().yellowColor,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ScreenColors().yellowColor,
                                          offset: Offset(0, 3.0),
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                          MediaQuery.of(context).size.width *
                                              .01,
                                          right:
                                          MediaQuery.of(context).size.width *
                                              .04,
                                          bottom:
                                          MediaQuery.of(context).size.width *
                                              .02),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Theme(
                                              data: Theme.of(context).copyWith(
                                                unselectedWidgetColor:
                                                ScreenColors().yellowColor,
                                              ),
                                              child: CheckboxListTile(
                                                checkColor: Colors.black,
                                                activeColor:
                                                ScreenColors().yellowColor,
                                                title: Text(
                                                  imageSizes[index],
                                                  style: TextStyle(
                                                      color: ScreenColors()
                                                          .yellowColor),
                                                ),
                                                value: dialogChecked1[index],
                                                onChanged: (val) {
                                                  setState(
                                                        () {
                                                      dialogChecked1[index] = val;
                                                      if (val == true) {
                                                        _itemCount1[index] = 1;
                                                      } else {
                                                        _itemCount1[index] = 0;
                                                      }
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Row(
                                                children: <Widget>[
                                                  _itemCount1[index] != 0
                                                      ? new IconButton(
                                                      icon: new Icon(
                                                        Icons.remove,
                                                        color: ScreenColors()
                                                            .yellowColor,
                                                      ),
                                                      onPressed: () {
                                                        if (dialogChecked1[index] == true && _itemCount1[index] != 0) {
                                                          setState(() {
                                                            _itemCount1[index]--;

                                                          });

                                                        } else {
                                                          setState(() {
                                                          });

                                                        }
                                                      })
                                                      : new Container(),
                                                  new Text(
                                                    _itemCount1[index].toString(),
                                                    style: TextStyle(
                                                        color: ScreenColors()
                                                            .yellowColor),
                                                  ),
                                                  new IconButton(
                                                      icon: new Icon(
                                                        Icons.add,
                                                        color: ScreenColors()
                                                            .yellowColor,
                                                      ),
                                                      onPressed: () {
                                                        if (dialogChecked1[index] == true) {
                                                          setState(() {
                                                            _itemCount1[index]++;
                                                          });

                                                        } else {
                                                          setState(() =>
                                                          _itemCount1[index]);
                                                        }
                                                      })
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                else{
                                  return Container(
                                    margin: EdgeInsets.only(
                                        bottom:
                                        MediaQuery.of(context).size.width *
                                            .02),
                                    width:
                                    MediaQuery.of(context).size.width * 100,
                                    height:
                                    MediaQuery.of(context).size.width * .20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.black,
                                      border: Border.all(
                                        width: 1.0,
                                        color: ScreenColors().yellowColor,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ScreenColors().yellowColor,
                                          offset: Offset(0, 3.0),
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                    ),
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            selectedImageSize1.clear();
                            selectedCount1.clear();
                            addSizesandCount1();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10.0),
                              ),
                              color: ScreenColors().yellowColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.16),
                                  offset: Offset(0, 3.0),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                                  Language=="en"?"OK":"موافق",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * .08),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  /// second dialog
  void __dialog2() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15)),
                child: Container(
                  height: MediaQuery.of(context).size.height * .5,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10.0),
                            ),
                            color: ScreenColors().yellowColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.16),
                                offset: Offset(0, 3.0),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                                Language=="en"?"Select Size and Quantity":"حدد الحجم والكمية",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * .05),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          color: ScreenColors().blackColor,
                          child: Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * .02),
                            child: ListView.builder(
                              itemCount: imageSizes.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.width *
                                              .02),
                                  width:
                                      MediaQuery.of(context).size.width * 100,
                                  height:
                                      MediaQuery.of(context).size.width * .20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.black,
                                    border: Border.all(
                                      width: 1.0,
                                      color: ScreenColors().yellowColor,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ScreenColors().yellowColor,
                                        offset: Offset(0, 3.0),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                .01,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                .04,
                                        bottom:
                                            MediaQuery.of(context).size.width *
                                                .02),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Theme(
                                            data: Theme.of(context).copyWith(
                                              unselectedWidgetColor:
                                                  ScreenColors().yellowColor,
                                            ),
                                            child: CheckboxListTile(
                                              checkColor: Colors.black,
                                              activeColor:
                                                  ScreenColors().yellowColor,
                                              title: Text(
                                                imageSizes[index],
                                                style: TextStyle(
                                                    color: ScreenColors()
                                                        .yellowColor),
                                              ),
                                              value: dialogChecked2[index],
                                              onChanged: (val) {
                                                setState(
                                                  () {
                                                    dialogChecked2[index] = val;
                                                    if (val == true) {
                                                      _itemCount2[index] = 1;
                                                    } else {
                                                      _itemCount2[index] = 0;
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Row(
                                              children: <Widget>[
                                                _itemCount2[index] != 0
                                                    ? new IconButton(
                                                        icon: new Icon(
                                                          Icons.remove,
                                                          color: ScreenColors()
                                                              .yellowColor,
                                                        ),
                                                        onPressed: () {
                                                          if (dialogChecked2[
                                                                      index] ==
                                                                  true &&
                                                              _itemCount2[
                                                                      index] !=
                                                                  0) {
                                                            setState(() =>
                                                                _itemCount2[
                                                                    index]--);
                                                          } else {
                                                            setState(() =>
                                                                _itemCount2[
                                                                    index]);
                                                          }
                                                        })
                                                    : new Container(),
                                                new Text(
                                                  _itemCount2[index].toString(),
                                                  style: TextStyle(
                                                      color: ScreenColors()
                                                          .yellowColor),
                                                ),
                                                new IconButton(
                                                    icon: new Icon(
                                                      Icons.add,
                                                      color: ScreenColors()
                                                          .yellowColor,
                                                    ),
                                                    onPressed: () {
                                                      if (dialogChecked2[
                                                              index] ==
                                                          true) {
                                                        setState(() =>
                                                            _itemCount2[
                                                                index]++);
                                                      } else {
                                                        setState(() =>
                                                            _itemCount2[index]);
                                                      }
                                                    })
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            selectedImageSize2.clear();
                            selectedCount2.clear();
                            addSizesandCount2();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10.0),
                              ),
                              color: ScreenColors().yellowColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.16),
                                  offset: Offset(0, 3.0),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                                  Language=="en"?"OK":"موافق",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * .08),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  /// 3rd dialog
  void __dialog3() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15)),
                child: Container(
                  height: MediaQuery.of(context).size.height * .5,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10.0),
                            ),
                            color: ScreenColors().yellowColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.16),
                                offset: Offset(0, 3.0),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              Language=="en"?"Select Size and Quantity":"حدد الحجم والكمية",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * .05),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          color: ScreenColors().blackColor,
                          child: Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * .02),
                            child: ListView.builder(
                              itemCount: imageSizes.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.width *
                                              .02),
                                  width:
                                      MediaQuery.of(context).size.width * 100,
                                  height:
                                      MediaQuery.of(context).size.width * .20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.black,
                                    border: Border.all(
                                      width: 1.0,
                                      color: ScreenColors().yellowColor,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ScreenColors().yellowColor,
                                        offset: Offset(0, 3.0),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                .01,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                .04,
                                        bottom:
                                            MediaQuery.of(context).size.width *
                                                .02),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Theme(
                                            data: Theme.of(context).copyWith(
                                              unselectedWidgetColor:
                                                  ScreenColors().yellowColor,
                                            ),
                                            child: CheckboxListTile(
                                              checkColor: Colors.black,
                                              activeColor:
                                                  ScreenColors().yellowColor,
                                              title: Text(
                                                imageSizes[index],
                                                style: TextStyle(
                                                    color: ScreenColors()
                                                        .yellowColor),
                                              ),
                                              value: dialogChecked3[index],
                                              onChanged: (val) {
                                                setState(
                                                  () {
                                                    dialogChecked3[index] = val;
                                                    if (val == true) {
                                                      _itemCount3[index] = 1;
                                                    } else {
                                                      _itemCount3[index] = 0;
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Row(
                                              children: <Widget>[
                                                _itemCount3[index] != 0
                                                    ? new IconButton(
                                                        icon: new Icon(
                                                          Icons.remove,
                                                          color: ScreenColors()
                                                              .yellowColor,
                                                        ),
                                                        onPressed: () {
                                                          if (dialogChecked3[
                                                                      index] == true && _itemCount3 != 0) {
                                                            setState(() =>
                                                                _itemCount3[
                                                                    index]--);
                                                          } else {
                                                            setState(() =>
                                                                _itemCount3[
                                                                    index]);
                                                          }
                                                        })
                                                    : new Container(),
                                                new Text(
                                                  _itemCount3[index].toString(),
                                                  style: TextStyle(
                                                      color: ScreenColors()
                                                          .yellowColor),
                                                ),
                                                new IconButton(
                                                    icon: new Icon(
                                                      Icons.add,
                                                      color: ScreenColors()
                                                          .yellowColor,
                                                    ),
                                                    onPressed: () {
                                                      if (dialogChecked3[
                                                              index] ==
                                                          true) {
                                                        setState(() =>
                                                            _itemCount3[
                                                                index]++);
                                                      } else {
                                                        setState(() =>
                                                            _itemCount3[index]);
                                                      }
                                                    })
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            selectedImageSize3.clear();
                            selectedCount3.clear();
                            addSizesandCount3();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10.0),
                              ),
                              color: ScreenColors().yellowColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.16),
                                  offset: Offset(0, 3.0),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                                  Language=="en"?"OK":"موافق",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * .08),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  /// 4rd dialog
  void __dialog4() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15)),
                child: Container(
                  height: MediaQuery.of(context).size.height * .5,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10.0),
                            ),
                            color: ScreenColors().yellowColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.16),
                                offset: Offset(0, 3.0),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              Language=="en"?"Select Size and Quantity":"حدد الحجم والكمية",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * .05),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          color: ScreenColors().blackColor,
                          child: Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * .02),
                            child: ListView.builder(
                              itemCount: imageSizes.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.width *
                                              .02),
                                  width:
                                      MediaQuery.of(context).size.width * 100,
                                  height:
                                      MediaQuery.of(context).size.width * .20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.black,
                                    border: Border.all(
                                      width: 1.0,
                                      color: ScreenColors().yellowColor,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ScreenColors().yellowColor,
                                        offset: Offset(0, 3.0),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                .01,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                .04,
                                        bottom:
                                            MediaQuery.of(context).size.width *
                                                .02),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Theme(
                                            data: Theme.of(context).copyWith(
                                              unselectedWidgetColor:
                                                  ScreenColors().yellowColor,
                                            ),
                                            child: CheckboxListTile(
                                              checkColor: Colors.black,
                                              activeColor:
                                                  ScreenColors().yellowColor,
                                              title: Text(
                                                imageSizes[index],
                                                style: TextStyle(
                                                    color: ScreenColors()
                                                        .yellowColor),
                                              ),
                                              value: dialogChecked4[index],
                                              onChanged: (val) {
                                                setState(
                                                  () {
                                                    dialogChecked4[index] = val;
                                                    if (val == true) {
                                                      _itemCount4[index] = 1;
                                                    } else {
                                                      _itemCount4[index] = 0;
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Row(
                                              children: <Widget>[
                                                _itemCount4[index] != 0
                                                    ? new IconButton(
                                                        icon: new Icon(
                                                          Icons.remove,
                                                          color: ScreenColors()
                                                              .yellowColor,
                                                        ),
                                                        onPressed: () {
                                                          if (dialogChecked4[
                                                                      index] ==
                                                                  true &&
                                                              _itemCount4 !=
                                                                  0) {
                                                            setState(() =>
                                                                _itemCount4[
                                                                    index]--);
                                                          } else {
                                                            setState(() =>
                                                                _itemCount4[
                                                                    index]);
                                                          }
                                                        })
                                                    : new Container(),
                                                new Text(
                                                  _itemCount4[index].toString(),
                                                  style: TextStyle(
                                                      color: ScreenColors()
                                                          .yellowColor),
                                                ),
                                                new IconButton(
                                                    icon: new Icon(
                                                      Icons.add,
                                                      color: ScreenColors()
                                                          .yellowColor,
                                                    ),
                                                    onPressed: () {
                                                      if (dialogChecked4[
                                                              index] ==
                                                          true) {
                                                        setState(() =>
                                                            _itemCount4[
                                                                index]++);
                                                      } else {
                                                        setState(() =>
                                                            _itemCount4[index]);
                                                      }
                                                    })
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            selectedImageSize4.clear();
                            selectedCount4.clear();
                            addSizesandCount4();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10.0),
                              ),
                              color: ScreenColors().yellowColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.16),
                                  offset: Offset(0, 3.0),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                                  Language=="en"?"OK":"موافق",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * .08),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  /// 4rd dialog
  void __dialog5() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15)),
                child: Container(
                  height: MediaQuery.of(context).size.height * .5,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10.0),
                            ),
                            color: ScreenColors().yellowColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.16),
                                offset: Offset(0, 3.0),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              Language=="en"?"Select Size and Quantity":"حدد الحجم والكمية",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * .05),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          color: ScreenColors().blackColor,
                          child: Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * .02),
                            child: ListView.builder(
                              itemCount: imageSizes.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.width *
                                              .02),
                                  width:
                                      MediaQuery.of(context).size.width * 100,
                                  height:
                                      MediaQuery.of(context).size.width * .20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.black,
                                    border: Border.all(
                                      width: 1.0,
                                      color: ScreenColors().yellowColor,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ScreenColors().yellowColor,
                                        offset: Offset(0, 3.0),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                .01,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                .04,
                                        bottom:
                                            MediaQuery.of(context).size.width *
                                                .02),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Theme(
                                            data: Theme.of(context).copyWith(
                                              unselectedWidgetColor:
                                                  ScreenColors().yellowColor,
                                            ),
                                            child: CheckboxListTile(
                                              checkColor: Colors.black,
                                              activeColor:
                                                  ScreenColors().yellowColor,
                                              title: Text(
                                                imageSizes[index],
                                                style: TextStyle(
                                                    color: ScreenColors()
                                                        .yellowColor),
                                              ),
                                              value: dialogChecked5[index],
                                              onChanged: (val) {
                                                setState(
                                                  () {
                                                    dialogChecked5[index] = val;
                                                    if (val == true) {
                                                      _itemCount5[index] = 1;
                                                    } else {
                                                      _itemCount5[index] = 0;
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Row(
                                              children: <Widget>[
                                                _itemCount5[index] != 0
                                                    ? new IconButton(
                                                        icon: new Icon(
                                                          Icons.remove,
                                                          color: ScreenColors()
                                                              .yellowColor,
                                                        ),
                                                        onPressed: () {
                                                          if (dialogChecked5[
                                                                      index] ==
                                                                  true &&
                                                              _itemCount5 !=
                                                                  0) {
                                                            setState(() =>
                                                                _itemCount5[
                                                                    index]--);
                                                          } else {
                                                            setState(() =>
                                                                _itemCount5[
                                                                    index]);
                                                          }
                                                        })
                                                    : new Container(),
                                                new Text(
                                                  _itemCount5[index].toString(),
                                                  style: TextStyle(
                                                      color: ScreenColors()
                                                          .yellowColor),
                                                ),
                                                new IconButton(
                                                    icon: new Icon(
                                                      Icons.add,
                                                      color: ScreenColors()
                                                          .yellowColor,
                                                    ),
                                                    onPressed: () {
                                                      if (dialogChecked5[
                                                              index] ==
                                                          true) {
                                                        setState(() =>
                                                            _itemCount5[
                                                                index]++);
                                                      } else {
                                                        setState(() =>
                                                            _itemCount5[index]);
                                                      }
                                                    })
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            selectedImageSize5.clear();
                            selectedCount5.clear();
                            addSizesandCount5();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10.0),
                              ),
                              color: ScreenColors().yellowColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.16),
                                  offset: Offset(0, 3.0),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                              Language=="en"?"OK":"موافق",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * .08),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  void addSizesandCount1() {
    for (int i = 0; i < imageSizes.length; i++) {
      if (dialogChecked1[i] != false && _itemCount1[i] != 0) {
        selectedImageSize1.add(imageSizes[i]);
        selectedCount1.add(_itemCount1[i]);
      }
    }
    print(selectedImageSize1);
    print(selectedCount1);
  }

  ///////////////////////////////////////////////////////////
  void addSizesandCount2() {
    for (int i = 0; i < imageSizes.length; i++) {
      if (dialogChecked2[i] != false && _itemCount2[i] != 0) {
        selectedImageSize2.add(imageSizes[i]);
        selectedCount2.add(_itemCount2[i]);
      }
    }
    print(selectedImageSize2);
    print(selectedCount2);
  }

  //////////////////////////////////////////////////////////

  void addSizesandCount3() {
    for (int i = 0; i < imageSizes.length; i++) {
      if (dialogChecked3[i] != false && _itemCount3[i] != 0) {
        selectedImageSize3.add(imageSizes[i]);
        selectedCount3.add(_itemCount3[i]);
      }
    }
    print(selectedImageSize3);
    print(selectedCount3);
  }

  //////////////////////////////////////////////
  void addSizesandCount4() {
    for (int i = 0; i < imageSizes.length; i++) {
      if (dialogChecked4[i] != false && _itemCount4[i] != 0) {
        selectedImageSize4.add(imageSizes[i]);
        selectedCount4.add(_itemCount4[i]);
      }
    }
    print(selectedImageSize4);
    print(selectedCount4);
  }

  ////////////////////////////////////////////////
  void addSizesandCount5() {
    for (int i = 0; i < imageSizes.length; i++) {
      if (dialogChecked5[i] != false && _itemCount5[i] != 0) {
        selectedImageSize5.add(imageSizes[i]);
        selectedCount5.add(_itemCount5[i]);
      }
    }
    print(selectedImageSize5);
    print(selectedCount5);
  }

  Future<void> fetchSize(int USERID) async {
    print("********************************************");
    dialogChecked1.clear();
    dialogChecked2.clear();
    dialogChecked3.clear();
    dialogChecked4.clear();
    dialogChecked5.clear();
    _itemCount1.clear();
    _itemCount2.clear();
    _itemCount3.clear();
    _itemCount4.clear();
    _itemCount5.clear();
    _sizes = await showSizes(USERID);
    print(_sizes.data[0].imgSize);
    imageSizes.clear();
    for (int i = 0; i < _sizes.data.length; i++) {
      imageSizes.add(_sizes.data[i].imgSize.toString());
      dialogChecked1.add(false);
      dialogChecked2.add(false);
      dialogChecked3.add(false);
      dialogChecked4.add(false);
      dialogChecked5.add(false);
      _itemCount1.add(0);
      _itemCount2.add(0);
      _itemCount3.add(0);
      _itemCount4.add(0);
      _itemCount5.add(0);
    }
    return _sizes;
  }
////////////////////////////////////////////////////////////////////////////////
  int totalBill1() {
    int sum1=0;
    for(int i=0;i<_sizes.data.length;i++){

      for(int j=0;j<selectedImageSize1.length;j++){
        if(_sizes.data[i].imgSize==selectedImageSize1[j]){
          print(_sizes.data[i].imgSize);
          print(_sizes.data[i].totalcost);
          var long2 = double.parse(_sizes.data[i].totalcost);
          var integer=long2.round()*_itemCount1[i];
          sum1=sum1+integer;
        }
      }
    }
    print(sum1);
    return sum1;
  }
  ////////////////////////////////////////////////////////////////////////////
  int totalBill2() {
    int sum2=0;
    for(int i=0;i<_sizes.data.length;i++){
      for(int j=0;j<selectedImageSize2.length;j++){
        if(_sizes.data[i].imgSize==selectedImageSize2[j]){
          var long2 = double.parse(_sizes.data[i].totalcost);
          var integer=long2.round()*_itemCount2[i];
          sum2=sum2+integer;
        }
      }
    }
    print(sum2);
    return sum2;
  }
  //////////////////////////////////////////////////////////////////////////////
  int totalBill3() {
    int sum3=0;
    for(int i=0;i<_sizes.data.length;i++){
      for(int j=0;j<selectedImageSize3.length;j++){
        if(_sizes.data[i].imgSize==selectedImageSize3[j]){
          var long2 = double.parse(_sizes.data[i].totalcost);
          var integer=long2.round()*_itemCount3[i];
          sum3=sum3+integer;
        }
      }
    }
    print(sum3);
    return sum3;
  }
  //////////////////////////////////////////////////////////////////////////
  int totalBill4() {
    int sum4=0;
    for(int i=0;i<_sizes.data.length;i++){
      for(int j=0;j<selectedImageSize4.length;j++){
        if(_sizes.data[i].imgSize==selectedImageSize4[j]){
          var long2 = double.parse(_sizes.data[i].totalcost);
          var integer=long2.round()*_itemCount4[i];
          sum4=sum4+integer;
        }
      }
    }
    print(sum4);
    return sum4;
  }
  //////////////////////////////////////////////////////////////////////////
  int totalBill5() {
    int sum5=0;
    for(int i=0;i<_sizes.data.length;i++){
      for(int j=0;j<selectedImageSize5.length;j++){
        if(_sizes.data[i].imgSize==selectedImageSize5[j]){
          var long2 = double.parse(_sizes.data[i].totalcost);
          var integer=long2.round()*_itemCount5[i];
          sum5=sum5+integer;
        }
      }
    }
    print(sum5);
    return sum5;
  }


Future<void> submitMultiPart(String id, int totalCost,String orderCode, int delievryCharges) async {

    /////////////////////////////////////////////////////////////////////////////////////
 if(images.length==1) {
   print("length---------------------------------1");
   print(selectedCount1);
   print(selectedImageSize1);
   print(id);
   print(orderCode);

   Map<String, String> headers = { "Content-Type": "multipart/form-data"};
   var request = http.MultipartRequest(
       'POST', Uri.parse('http://fotod.io/api/picturesubmit'));

   request.fields.addAll({
     'customerID': id,
     'ordercode': orderCode,
     'pic1qty': selectedCount1.join(',').toString(),
     'pic1size': selectedImageSize1.join(',').toString(),
     'sponsorID':"0",
     'imagesize':" "
   });
print(path[0]);
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
             builder: (context) => PlaceOrderScreen(totalCost, orderCode, id, delievryCharges)));
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
     'customerID': id,
     'ordercode': orderCode,
     'pic1qty': selectedCount1.join(',').toString(),
     'pic1size': selectedImageSize1.join(',').toString(),
     'pic2qty': selectedCount2.join(',').toString(),
     'pic2size': selectedImageSize2.join(',').toString(),
     'sponsorID':"0",
     'imagesize':" "

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
             builder: (context) => PlaceOrderScreen(totalCost,orderCode, id, delievryCharges)));
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
      'customerID': id,
      'ordercode': orderCode,
      'pic1qty': selectedCount1.join(',').toString(),
      'pic1size': selectedImageSize1.join(',').toString(),
      'pic2qty': selectedCount2.join(',').toString(),
      'pic2size': selectedImageSize2.join(',').toString(),
      'pic3qty': selectedCount3.join(',').toString(),
      'pic3size': selectedImageSize3.join(',').toString(),
      'sponsorID':"0",
      'imagesize':" "
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
              builder: (context) => PlaceOrderScreen(totalCost,orderCode, id, delievryCharges)));
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
      'customerID': id,
      'ordercode': orderCode,
      'pic1qty': selectedCount1.join(',').toString(),
      'pic1size': selectedImageSize1.join(',').toString(),
      'pic2qty': selectedCount2.join(',').toString(),
      'pic2size': selectedImageSize2.join(',').toString(),
      'pic3qty': selectedCount3.join(',').toString(),
      'pic3size': selectedImageSize3.join(',').toString(),
      'pic4qty': selectedCount4.join(',').toString(),
      'pic4size': selectedImageSize4.join(',').toString(),
      'sponsorID':"0",
      'imagesize':" "
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
              builder: (context) => PlaceOrderScreen(totalCost,orderCode, id, delievryCharges)));
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
      'customerID': id,
      'ordercode': orderCode,
      'pic1qty': selectedCount1.join(',').toString(),
      'pic1size': selectedImageSize1.join(',').toString(),
      'pic2qty': selectedCount2.join(',').toString(),
      'pic2size': selectedImageSize2.join(',').toString(),
      'pic3qty': selectedCount3.join(',').toString(),
      'pic3size': selectedImageSize3.join(',').toString(),
      'pic4qty': selectedCount4.join(',').toString(),
      'pic4size': selectedImageSize4.join(',').toString(),
      'pic5qty': selectedCount5.join(',').toString(),
      'pic5size': selectedImageSize5.join(',').toString(),
      'sponsorID':"0",
      'imagesize':" "
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
              builder: (context) => PlaceOrderScreen(totalCost,orderCode, id,delievryCharges)));
    }
    else {
      print(response.reasonPhrase);
    }
  }
 ///////////////////////////////////////////////////////////////////////////
}
////////////////////////////////////////////////////////////////////////////////////////////////////////
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
          ),
          )),
        ],
      ),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}
