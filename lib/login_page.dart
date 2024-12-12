import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monety_expense_tracker_app/forgot_password_page.dart';
import 'package:monety_expense_tracker_app/home_page.dart';
import 'package:monety_expense_tracker_app/signup_page.dart';

class LoginPage extends StatefulWidget{
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios_new,size: 30,)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Row(
              children: [
                const Text("Log in",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 25),),
                const SizedBox(width: 5,),
                Image.asset("assets/images/shooting_star.png",width: 25,height: 25)
              ],
            ),
            const SizedBox(height: 5,),
            const Text("Welcome back! Please enter your details.",style: TextStyle(fontSize: 16,color: Colors.grey),),
            const SizedBox(height: 15,),
            const Text("Email",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            TextField(
              keyboardType: TextInputType.emailAddress ,
              cursorColor: const Color(0xffE78BBC),
              decoration: InputDecoration(
                enabledBorder: enableBorder(),
                focusedBorder: focusedBorder(),
                prefixIcon: const Icon(Icons.email_outlined,color: Colors.grey,),
                hintText: "Enter your email",
                hintStyle: const TextStyle(fontSize: 16,color: Colors.grey),
              ),
            ),
            const SizedBox(height: 15,),
            const Text("Password",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            TextField(
              keyboardType: TextInputType.visiblePassword ,
              obscureText: true,
              cursorColor: const Color(0xffE78BBC),
              decoration: InputDecoration(
                enabledBorder:enableBorder(),
                focusedBorder: focusedBorder(),
                prefixIcon: const Icon(Icons.lock_outline_rounded,color: Colors.grey,),
                suffixIcon: const Icon(Icons.visibility_off_outlined,color: Colors.grey,),
                hintText: "Enter your password",
                hintStyle: const TextStyle(fontSize: 16,color: Colors.grey),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: check, onChanged:(value) {
                        setState(() {
                          check = value!;
                        });
                    },activeColor: const Color(0xffE78BBC),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),),
                    const Text("Remember for 30 days",style: TextStyle(color:Colors.grey,fontSize: 14 ),),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage(),));
                  },
                    child: const Text("Forgot password?",style: TextStyle(color: Color(0xffE78BBC),fontSize: 14))),
              ],
            ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePage(),));
            },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffE78BBC),
                    elevation: 3,
                    shadowColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                child: const Text("Log In",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: Container(height: 1,color: Colors.grey,)),
                const SizedBox(width: 10,),
                const Text("Or log in with",style: TextStyle(color: Colors.grey,fontSize: 12),),
                const SizedBox(width: 10,),
                Expanded(child: Container(height: 1,color: Colors.grey,)),
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 3,
                  shadowColor: Colors.black,
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Image.asset("assets/images/google.png"),
                    ),
                  ),
                ),
                const SizedBox(width: 15,),
                Card(
                  elevation: 3,
                  shadowColor: Colors.black,
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Image.asset("assets/images/facebook.png"),
                    ),
                  ),
                ),
                const SizedBox(width: 15,),
                Card(
                  elevation: 3,
                  shadowColor: Colors.black,
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Image.asset("assets/images/apple.png"),
                    ),
                  ),
                )
              ],
            ),
             Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Don't have an account?",style: TextStyle(color: Colors.grey,fontSize: 14),),
                    const SizedBox(width: 5,),
                    InkWell(
                      child: const Text("Sign up",style: TextStyle(color:Color(0xffE78BBC),fontSize: 14,fontWeight: FontWeight.bold,)),
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) => SignUpPage(),));
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  OutlineInputBorder enableBorder(){
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 2,
        )
    );
  }

  OutlineInputBorder focusedBorder(){
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xffE78BBC),
          width: 2,
        )
    );
  }
}