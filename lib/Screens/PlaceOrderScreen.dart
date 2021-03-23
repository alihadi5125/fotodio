import 'package:flutter/material.dart';
import 'package:fotodio/Screens/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fotodio/Screens/modelclasses/placeOrderModel.dart';
import 'package:fotodio/Screens/ImagePickerScreen.dart';
import 'package:http/http.dart' as http;
import 'package:fotodio/Models/coupon.dart';
import 'package:fluttertoast/fluttertoast.dart';
class PlaceOrderScreen extends StatefulWidget {
  int totalBill;
  String OrderCode;
  String id;
  int delieveryCharges;
  PlaceOrderScreen(this.totalBill, this.OrderCode,this.id, this.delieveryCharges);

  @override
  _PlaceOrderScreenState createState() => _PlaceOrderScreenState(totalBill+delieveryCharges);
}
////////////////////////////////////////////////////////////////////////////////
Future<PlaceOrder> placeOrder(String userId, String Name, String Phone, String adress, String zip, String City, String Country,
    String totalBill, String OrderCode) async {
  print("data here is ");
  print(userId);
  print(Name);
  print(Phone);
  print(adress);
  print(zip);
  print(City);
  print(Country);
  print(totalBill);
  print(OrderCode);
  final String apiUrl = "http://fotod.io/api/placeorder";
  final response = await http.post(apiUrl, body: {
    "customerID":  userId,
    "name": Name,
    "phone":Phone,
    "shipping_address": adress,
    "zip_code":  zip,
    "city": City,
    "country": Country,
    "totalbill": totalBill,
    "ordercode": OrderCode
  });

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return PlaceOrder.fromRawJson(responseString);
  } else {
    return null;
  }
}


class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  Future<void> completeOrder(String userId, String Name, String Phone,
      String adress, String zip, String City, String Country,
      String totalBill, String OrderCode, var context) async {
    PlaceOrder obj = await placeOrder(
        userId,
        Name,
        Phone,
        adress,
        zip,
        City,
        Country,
        totalBill,
        OrderCode);
    print(obj.message);
    if (obj.message == "detail") {
      dialog(context);
    }
  }

  void dialog(var context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)), //this right here
            child: Container(

              decoration: BoxDecoration(
                color: ScreenColors().blackColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Expanded(
                        flex: 1,
                        child: Center(child: Icon(
                            Icons.check_circle_outline, size: MediaQuery
                            .of(context)
                            .size
                            .height * .1,
                            color: ScreenColors().yellowColor
                        ))),
                    Expanded(flex: 3, child: Align(
                      alignment: Alignment.center,
                      child: Language == "en" ? Text(
                        "Your Order Has Been Placed Successfully",
                        style: TextStyle(
                            fontSize: MediaQuery
                                .of(context)
                                .size
                                .height * .02,
                            color: ScreenColors().yellowColor
                        ),
                      ) : Text("تم تقديم طلبك بنجاح", style: TextStyle(
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .height * .02,
                          color: ScreenColors().yellowColor
                      ),
                      ),
                    ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: 320.0,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImagePickerScreen()));
                          },
                          child: Text(
                            Language == "en" ? "OK" : "فعله",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: const Color(0xFF1BC0C5),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  int FullPrice;

  _PlaceOrderScreenState(this.FullPrice);

  String Language;

  void fetchLaguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var lan = prefs.getString("language");
    setState(() {
      Language = lan;
    });
  }

  bool check;
  String Fullname;
  String Email;
  String Phone;
  String Country;
  String City;
  String Adress;
  int userid;
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

  void initState() {
    super.initState();
    fetchStorageData();
    fetchLaguage();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController adressLine2Controller = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  Future<void> fetchStorageData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('userId');
    var name = prefs.getString('firstName');
    var email = prefs.getString('email');
    var mobile = prefs.getString('mobile');
    var country = prefs.getString('country');
    var city = prefs.getString('city');
    var address = prefs.getString('address');

    print(userId);
    print(name);
    print(email);
    print(mobile);
    print(country);
    print(city);
    print(address);

    setState(() {
      Fullname = name;
      Email = email;
      Phone = mobile;
      Country = country;
      City = city;
      Adress = address;
      userid = userId;
      nameController.text = Fullname;
      emailController.text = Email;
      phoneController.text = Phone;
      cityController.text = City;
      adressController.text = Adress;
      countryController.text = Country;
      /////////////////////////////////////////////////////////////////
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ScreenColors().yellowColor,
            shadowColor: ScreenColors().yellowColor,
            centerTitle: true,
            title: Text(
              Language == "en" ? "Place Order" : "أكد الطلب",
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: ScreenColors().blackColor,
          body: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.55,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: TextField(
                            controller: nameController,
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
                                hintText: Language == "en" ? 'Name' : 'اسم',
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
                                nameValidate ? Language == "en"
                                    ? "Name is Mandatory"
                                    : "الاسم إلزامي" : null,
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
                                    controller: emailController,
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
                                        hintText: Language == "en"
                                            ? 'Email'
                                            : "'البريد الإلكتروني'",
                                        errorText: emailValidate
                                            ? Language == "en"
                                            ? "Email is Mandatory"
                                            : "البريد الإلكتروني إلزامي"
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
                              Expanded(
                                child: Container(
                                  child: TextField(
                                    style: TextStyle(
                                        color: ScreenColors().yellowColor),
                                    controller: phoneController,
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
                                        hintText: Language == "en"
                                            ? 'Phone'
                                            : 'هاتف',
                                        errorText: phoneValidate
                                            ? Language == "en"
                                            ? "Phone Number is Mandatory"
                                            : "رقم الهاتف إلزامي"
                                            : null,
                                        hintStyle: TextStyle(
                                            color: ScreenColors()
                                                .yellowColor
                                                .withOpacity(.8))),
                                    onChanged: (String name) {
                                      if (name.isEmpty) {
                                        setState(() {
                                          phoneValidate = true;
                                        });
                                        FocusScope.of(context).requestFocus(f3);
                                      } else {
                                        setState(() {
                                          phoneValidate = false;
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
                          child: TextField(
                            style: TextStyle(color: ScreenColors().yellowColor),
                            controller: adressController,
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
                                hintText: Language == "en"
                                    ? 'Address'
                                    : 'عنوان',
                                errorText: adressValidate
                                    ? Language == "en"
                                    ? "Adress is Mandatory"
                                    : "العنوان إلزامي"
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
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: TextField(
                                    style: TextStyle(
                                        color: ScreenColors().yellowColor),
                                    controller: zipController,
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
                                        hintText: Language == "en"
                                            ? 'ZIP/Post Code'
                                            : "الرمز البريدي",
                                        errorText: zipValidate
                                            ? Language == "en"
                                            ? "Zip Code is Mandatory"
                                            : "الرمز البريدي إلزامي"
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
                                    controller: cityController,
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
                                        hintText: Language == "en"
                                            ? 'City'
                                            : 'مدينة',
                                        errorText: cityValidate
                                            ? Language == "en"
                                            ? "City is Mandatory"
                                            : "المدينة إلزامية"
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
                                    controller: stateController,
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
                                        hintText: Language == "en"
                                            ? 'State/Province/Region'
                                            : 'الدولة / الإقليم / المنطقة',
                                        errorText: stateValidate
                                            ? Language == "en"
                                            ? "State is Mandatory"
                                            : "المحافظة إلزامية"
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
                                    controller: countryController,
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
                                        hintText: Language == "en"
                                            ? 'Country'
                                            : 'بلد',
                                        errorText: countryValidate
                                            ? "البلد إلزامي"
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
                      Expanded(
                        child: Container(
                          child: TextField(
                            style: TextStyle(color: ScreenColors().yellowColor),
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
                                hintText: Language == "en"
                                    ? 'Payment Options'
                                    : 'خيارات الدفع',
                                hintStyle: TextStyle(
                                    color: ScreenColors()
                                        .yellowColor
                                        .withOpacity(.8)),
                                suffixIcon: Container(
                                  padding: EdgeInsets.all(10),
                                  width: 125,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                              borderRadius:
                                              BorderRadius.circular(12)),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                          'images/Gmail.png',
                                                        ),
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  alignment:
                                                  Alignment.centerRight,
                                                  child: Text(
                                                    'Pay',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: ScreenColors()
                                                            .yellowColor
                                                            .withOpacity(.8)),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Icon(
                                            Icons.arrow_drop_down,
                                            color: ScreenColors()
                                                .yellowColor
                                                .withOpacity(.8),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.07,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: ScreenColors().yellowColor.withOpacity(.8),
                              width: 1))),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    Language == "en"
                                        ? 'Actual Bill'
                                        : "الفاتورة الفعلية",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ScreenColors()
                                            .yellowColor
                                            .withOpacity(.8)),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    widget.totalBill.toString() + "د.ا ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ScreenColors()
                                            .yellowColor
                                            .withOpacity(.8)),
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
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    Language == "en"
                                        ? 'Delievery Charges'
                                        : " رسوم التوصيل",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ScreenColors()
                                            .yellowColor
                                            .withOpacity(.8)),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    widget.delieveryCharges.toString() + "د.ا ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ScreenColors()
                                            .yellowColor
                                            .withOpacity(.8)),
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
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    Language == "en"
                                        ? 'Total Bill'
                                        : "إجمالي الفاتورة",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ScreenColors()
                                            .yellowColor
                                            .withOpacity(.8)),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    FullPrice.toString() + "د.ا ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ScreenColors()
                                            .yellowColor
                                            .withOpacity(.8)),
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
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: ScreenColors().yellowColor.withOpacity(.8),
                  ),
                  margin: EdgeInsets.only(
                    left: 240,
                  ),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.05,
                  child: RaisedButton(
                    color: ScreenColors().yellowColor.withOpacity(.8),
                    onPressed: () {
                      _displayTextInputDialog(context);
                    },
                    child: Text(
                      Language == "en" ? 'I Have a Coupon' : "لدي قسيمة",
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery
                          .of(context)
                          .size
                          .width * .08,
                      left: MediaQuery
                          .of(context)
                          .size
                          .width * .05,
                      right: MediaQuery
                          .of(context)
                          .size
                          .width * .05,
                    ),
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: ScreenColors().yellowColor.withOpacity(.8),
                      ),
                      child: RaisedButton(
                        onPressed: () {
                          int totalPrice = widget.totalBill +
                              widget.delieveryCharges;
                          if (validate()) {
                            completeOrder(
                                widget.id,
                                nameController.text,
                                phoneController.text,
                                adressController.text +
                                    adressLine2Controller.text,
                                zipController.text,
                                cityController.text,
                                countryController.text,
                                totalPrice.toString(),
                                widget.OrderCode,
                                context);
                          }
                        },
                        color: ScreenColors().yellowColor.withOpacity(.8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          Language == "en" ? 'Confirm & Pay' : 'تأكيد وادفع',
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

  Future<void> _displayTextInputDialog(BuildContext context) async {
    TextEditingController controller = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: ScreenColors().blackColor,
            title: Text('Coupon', style: TextStyle(
              color: ScreenColors().yellowColor,
            ),),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(
                  hintText: "Enter Coupon Code", hintStyle: TextStyle(
                color: ScreenColors().yellowColor,
              )),
            ),
            actions: [
              RaisedButton(

                color: ScreenColors().yellowColor,
                child: Text('Ok', style: TextStyle(
                  color: Colors.white,
                ),),
                onPressed: () async {
                  showCoupon(controller.text);
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  Future<Coupon> showCoupon(String code) async {
    final String apiUrl = "http://fotod.io/api/promotions";
    final response = await http.post(apiUrl, body: {
      "code": code
    });
    Fluttertoast.showToast(
        msg: "Coupon is invalid",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: ScreenColors().yellowColor,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  bool validate() {
    /////////////////////////////////////////////////////////////
    if (nameController.text.isEmpty) {
      setState(() {
        nameValidate = true;
        FocusScope.of(context).requestFocus(f1);
      });
    } else if (nameController.text.isNotEmpty) {
      setState(() {
        nameValidate = false;
      });

      f1.unfocus();
    }
    ////////////////////////////////////////////////////////////

    if (emailController.text.isEmpty) {
      setState(() {
        emailValidate = true;
        FocusScope.of(context).requestFocus(f2);
      });
    } else if (emailController.text.isNotEmpty) {
      setState(() {
        emailValidate = false;
      });
      f2.unfocus();
    }
    ////////////////////////////////////////////////////////////

    if (phoneController.text.isEmpty) {
      setState(() {
        phoneValidate = true;
        FocusScope.of(context).requestFocus(f3);
      });
    } else {
      phoneValidate = false;
      f3.unfocus();
    }
    ////////////////////////////////////////////////////////////
    if (adressController.text.isEmpty) {
      setState(() {
        adressValidate = true;
        FocusScope.of(context).requestFocus(f4);
      });
    } else {
      adressValidate = false;
      f4.unfocus();
    }
    ////////////////////////////////////////////////////////////

    if (zipController.text.isEmpty) {
      setState(() {
        zipValidate = true;
        FocusScope.of(context).requestFocus(f6);
      });
    } else {
      zipValidate = false;
      f6.unfocus();
    }
    ////////////////////////////////////////////////////////////

    if (cityController.text.isEmpty) {
      setState(() {
        cityValidate = true;
        FocusScope.of(context).requestFocus(f7);
      });
    } else {
      cityValidate = false;
      f7.unfocus();
    }
    ////////////////////////////////////////////////////////////

    if (stateController.text.isEmpty) {
      setState(() {
        stateValidate = true;
        FocusScope.of(context).requestFocus(f8);
      });
    } else {
      stateValidate = false;
      f8.unfocus();
    }
    ////////////////////////////////////////////////////////////
    if (countryController.text.isEmpty) {
      setState(() {
        countryValidate = true;
        FocusScope.of(context).requestFocus(f9);
      });
    } else {
      countryValidate = false;
      f9.unfocus();
    }
    if (nameController.text.isNotEmpty && emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty
        && adressController.text.isNotEmpty && zipController.text.isNotEmpty &&
        countryController.text.isNotEmpty && cityController.text.isNotEmpty &&
        stateController.text.isNotEmpty
    ) {
      return true;
    }
    else {
      return false;
    }
    ////////////////////////////////////////////////////////////
  }

}
