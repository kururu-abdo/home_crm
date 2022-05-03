import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_crm/views/home.dart';
import 'package:home_crm/widgets/anim_dots.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

    });
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
       
            Image.asset('assets/images/crm.png' , width: 200,height: 200,) ,
      
          SizedBox(height: 200,) ,
            JumpingDotsProgressIndicator(
        numberOfDots: 3,
      ),
      
      
      
          ],
        ),
      ),
    );
  }
}