import 'package:flutter/material.dart';
import 'package:fotodio/Screens/colors.dart';
import 'package:fotodio/Models/responseModel.dart';
import 'package:http/http.dart' as http;



class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState(){
    super.initState();
    notification();

  }
  Response response;
  Future<Response> notification() async {
    final String apiUrl = "http://fotod.io/api/promotions";
    final response = await http.post(apiUrl, body: {

    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      Response res=await Response.fromRawJson(responseString);
      return res;
    } else {
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ScreenColors().blackColor,
        appBar: AppBar(
          backgroundColor: ScreenColors().yellowColor,
          title: Text(
            "Notifications",
            style: TextStyle(
              color:Colors.white
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.height*.02, right: MediaQuery.of(context).size.height*.02),
      child:FutureBuilder(
        future: notification(),
        builder: (BuildContext context, AsyncSnapshot<Response> projectSnap) {
          return ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext ctxt, int index) {
              if(projectSnap.hasData){
                return new Container(
                  margin: EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .size
                      .height * .04),
                  width: 308.0,
                  height: 84.0,
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
                    padding: EdgeInsets.only(left: MediaQuery
                        .of(context)
                        .size
                        .height * .02),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.circle_notifications,
                          color: ScreenColors().yellowColor,
                        ),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .height * .02,
                        ),
                        Expanded(
                          child: Text(
                          "motificatrion",
                            style: TextStyle(
                                color: ScreenColors().yellowColor
                            ),
                          ),
                        )],
                    )
                    ,
                  )
                  ,
                );
              }
              else{
                return new Container(
                  margin: EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .size
                      .height * .04),
                  width: 308.0,
                  height: 84.0,
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
                    padding: EdgeInsets.only(left: MediaQuery
                        .of(context)
                        .size
                        .height * .02),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.circle_notifications,
                          color: ScreenColors().yellowColor,
                        ),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .height * .02,
                        ),
                        Expanded(
                          child: Text(
                            "No Notification Avaialble",
                            style: TextStyle(
                                color: ScreenColors().yellowColor
                            ),
                          ),
                        ),
    ]
                    ),
                  )
                  ,
                );
              }
              }
          );
        }
      ),
//
//

        ),

      ),
    );
  }
}
