import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monety_expense_tracker_app/login_page.dart';

class ResetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 120,),
            Row(
              children: [
                const Text("Reset your password ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                const SizedBox(width: 5,),
                Image.asset(
                    "assets/images/reset_password.png", width: 25, height: 25)
              ],
            ),
            const SizedBox(height: 10,),
            const Text("The password must be different than before.",
              style: TextStyle(fontSize: 16, color: Colors.grey),),
            const SizedBox(height: 10,),
            Center(child: Image.asset("assets/images/forgot_password_img.jpg",width: 200,height: 200,)),
            const SizedBox(height: 10,),
            const Text("New Password",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              cursorColor: const Color(0xffE78BBC),
              decoration: InputDecoration(
                enabledBorder: enableBorder(),
                focusedBorder: focusedBorder(),
                prefixIcon: const Icon(
                  Icons.lock_outline_rounded, color: Colors.grey,),
                suffixIcon: const Icon(
                  Icons.visibility_off_outlined, color: Colors.grey,),
                hintText: "New password",
                hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 15,),
            const Text("Confirm Password",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              cursorColor: const Color(0xffE78BBC),
              decoration: InputDecoration(
                enabledBorder: enableBorder(),
                focusedBorder: focusedBorder(),
                  prefixIcon: const Icon(
                  Icons.lock_outline_rounded, color: Colors.grey,),
                  suffixIcon: const Icon(
                  Icons.visibility_off_outlined, color: Colors.grey,),
                   hintText: "Confirm password",
                  hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginPage(),));
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

  OutlineInputBorder enableBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 2,
        )
    );
  }

  OutlineInputBorder focusedBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xffE78BBC),
          width: 2,
        )
    );
  }
}