import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fotodio/Screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fotodio/Screens/colors.dart';
class onBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
      ),
      home: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  String Language;
  static const Color blackColor=Color(0xff424242);
  static const Color yellowColor=Color(0xff36DCE8);
  final introKey = GlobalKey<IntroductionScreenState>();
  @override
  void initState(){
   super.initState();
   fetchLaguage();
  }

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  Widget _buildImage(String assetName) {
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: Align(
        child: Container(
          width: 350,
            decoration: BoxDecoration(

              image: DecorationImage(

                image: AssetImage('images/$assetName.png',)

              )
            ),
            child: Image.asset('images/$assetName.png', width: 350.0)),
        alignment: Alignment.bottomCenter,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0, color: yellowColor);
    const pageDecoration = const PageDecoration(

      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700, color: yellowColor),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      titlePadding: EdgeInsets.fromLTRB(10, 30, 10, 0),
      pageColor: blackColor,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(

      key: introKey,
      pages: [


        PageViewModel(
          title: Language=="en"?"Capture the beautiful moments using your mobile phone":"التقط اللحظات الجميلة باستخدام هاتفك المحمول",
          body: "",
          image: _buildImage('onboard1'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: Language=="en"?"Upload Your Images and Complete Your Order !":"قم بتحميل صورك وأكمل طلبك!",
          body:
          "",
          image: _buildImage('onboard2'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: Language=="en"?"Order Delivery at Your Doorstep !":"اطلب التسليم على عتبة داركم!",
          body:
          "",
          image: _buildImage('onboard3'),
          decoration: pageDecoration,
        ),

      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: Language=="en"?const Text('Skip',style:  TextStyle( color: yellowColor),):const Text('تخطى',style:  TextStyle( color: yellowColor),),
      next: const Icon(Icons.arrow_forward, color: yellowColor,),
      done: Language=="en"?const Text('Done', style: TextStyle(fontWeight: FontWeight.w600,color: yellowColor)):const Text('فعله', style: TextStyle(fontWeight: FontWeight.w600,color: yellowColor)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: yellowColor,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  void fetchLaguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   var lan= prefs.getString("language");
   setState(() {
     Language=lan;
   });
  }
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: const Text('Home')),
        body: const Center(child: Text("This is the screen after Introduction")),
      ),
    );
  }
}