import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monety_expense_tracker_app/ui/reset_password_page.dart';

class VerificationPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 120,),
            Row(
              children: [
                const Text("Enter verification code",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 25),),
                const SizedBox(width: 5,),
                Image.asset("assets/images/check.png",width: 25,height: 25)
              ],
            ),
            const SizedBox(height: 10,),
            const Text("We have sent a code to kk@gmail.com",style: TextStyle(fontSize: 16,color: Colors.grey),),
            const SizedBox(height: 10,),
            Center(child: Image.asset("assets/images/verify_email_img.jpg",width: 200,height: 200,)),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 80,
                  height: 50,
                  child:TextField(
                    keyboardType: TextInputType.number ,
                    cursorColor: const Color(0xffE78BBC),
                    cursorHeight: 26,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 26,fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      enabledBorder: enableBorder(),
                      focusedBorder: focusedBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  height: 50,
                  child:TextField(
                    keyboardType: TextInputType.number ,
                    cursorColor: const Color(0xffE78BBC),
                    cursorHeight: 26,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 26,fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      enabledBorder: enableBorder(),
                      focusedBorder: focusedBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  height: 50,
                  child:TextField(
                    keyboardType: TextInputType.number ,
                    cursorColor: const Color(0xffE78BBC),
                    cursorHeight: 26,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 26,fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      enabledBorder: enableBorder(),
                      focusedBorder: focusedBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  height: 50,
                  child:TextField(
                    keyboardType: TextInputType.number ,
                    cursorColor: const Color(0xffE78BBC),
                    cursorHeight: 26,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 26,fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      enabledBorder: enableBorder(),
                      focusedBorder: focusedBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ResetPasswordPage(),));
            },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffE78BBC),
                    elevation: 3,
                    shadowColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                child: const Text("Verify Now",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Didn't you receive any code?",style: TextStyle(color: Colors.grey,fontSize: 14),),
                    const SizedBox(width: 5,),
                    InkWell(
                      child: const Text("Resend code",style: TextStyle(color:Color(0xffE78BBC),fontSize: 14,fontWeight: FontWeight.bold, )),
                      onTap: () {
                        //Navigator.push(context,MaterialPageRoute(builder: (context) => SignUpPage(),));
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