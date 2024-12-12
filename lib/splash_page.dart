import 'dart:async';
import 'package:flutter/material.dart';
import 'package:monety_expense_tracker_app/login_page.dart';

class SplashPage extends StatefulWidget{

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5),() {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginPage(),));
    },);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/monety_logo.jpg",width: 30,height: 30,),
                const Text("Monety",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              ],
            ),
            const SizedBox(height: 50,),
            Image.asset("assets/images/splash_img.png",width: 350,height: 350,fit: BoxFit.fill,),
            const SizedBox(height: 40,),
            const Text("Easy way to monitor",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
            const Text("your expense",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),
            const Text("Safe your future by managing your",style: TextStyle(color: Colors.grey,fontSize: 16),),
            const Text("expense right now",style: TextStyle(color: Colors.grey,fontSize: 16),),
          ],
        ),
      ),
    );
  }
}