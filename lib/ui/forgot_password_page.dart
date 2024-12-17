import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monety_expense_tracker_app/ui/verification_page.dart';

class ForgotPasswordPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                const Text("Forgot password",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 25),),
                const SizedBox(width: 5,),
                Image.asset("assets/images/forgot_password.png",width: 25,height: 25)
              ],
            ),
            const SizedBox(height: 10,),
            const Text("Enter your email account to reset password",style: TextStyle(fontSize: 16,color: Colors.grey),),
            const SizedBox(height: 10,),
            Center(child: Image.asset("assets/images/forgot_password_img.jpg",width: 200,height: 200,)),
            const SizedBox(height: 10,),
            const Text("Email",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            TextField(
              keyboardType: TextInputType.emailAddress ,
              cursorColor: const Color(0xffE78BBC),
              decoration: InputDecoration(
                enabledBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 2,
                    )
                ),
                focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xffE78BBC),
                  width: 2,
                )
              ),
                prefixIcon: const Icon(Icons.email_outlined,color: Colors.grey,),
                hintText: "Enter your email",
                hintStyle: const TextStyle(fontSize: 16,color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => VerificationPage(),));
            },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffE78BBC),
                    elevation: 3,
                    shadowColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                child: const Text("Continue",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
          ],
        ),
      ),
    );
  }
}