import 'package:flutter/material.dart';
import 'package:monety_expense_tracker_app/data/local/db_helper.dart';
import 'package:monety_expense_tracker_app/data/local/model/user_model.dart';

class SignUpPage extends StatefulWidget{
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool check = false;
  bool visibility = false;
  DbHelper dbHelper = DbHelper.getInstance();
  List<UserModel> userData = [ ];
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                const Text("Create an account",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 25),),
                const SizedBox(width: 5,),
                Image.asset("assets/images/shooting_star.png",width: 25,height: 25,)
              ],
            ),
            const SizedBox(height: 5,),
            const Text("Welcome! Please enter your details.",style: TextStyle(fontSize: 16,color: Colors.grey),),
            const SizedBox(height: 15,),
            const Text("Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            TextField(
              controller: nameController,
              keyboardType: TextInputType.name ,
              cursorColor: const Color(0xffE78BBC),
              decoration: InputDecoration(
                enabledBorder: enableBorder(),
                focusedBorder: focusedBorder(),
                prefixIcon: const Icon(Icons.account_circle_outlined,color: Colors.grey),
                hintText: "Enter your name",
                hintStyle: const TextStyle(fontSize: 14,color:  Colors.grey),
              ),
            ),
            const SizedBox(height: 15,),
            const Text("Email",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress ,
              cursorColor: const Color(0xffE78BBC),
              decoration: InputDecoration(
                enabledBorder: enableBorder(),
                focusedBorder: focusedBorder(),
                prefixIcon: const Icon(Icons.email_outlined,color: Colors.grey),
                hintText: "Enter your email",
                hintStyle: const TextStyle(fontSize: 14,color:  Colors.grey),
              ),
            ),
            const SizedBox(height: 15,),
            const Text("Password",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            TextField(
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword ,
              cursorColor: const Color(0xffE78BBC),
              obscureText: visibility ? false : true,
              decoration: InputDecoration(
                enabledBorder:enableBorder(),
                focusedBorder: focusedBorder(),
                prefixIcon: const Icon(Icons.lock_outline_rounded,color:  Colors.grey),
                suffixIcon:  IconButton(onPressed: (){
                  setState(() {
                    visibility = !visibility;
                  });
                },
                  icon: visibility==true ?const Icon(Icons.visibility_outlined,color: Colors.grey,) :const Icon(Icons.visibility_off_outlined,color: Colors.grey,),),
                hintText: "Enter your password",
                hintStyle: const TextStyle(fontSize: 14,color: Colors.grey),
              ),
            ),
            Row(
              children: [
                Checkbox(value: check, onChanged:(value) {
                  setState(() {
                    check = value!;
                  });
                },activeColor:const Color(0xffE78BBC),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),),
                const Text("Must be at least 8 characters",style: TextStyle(color: Colors.grey,fontSize: 14 ),)
              ],
            ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: () async{
              ///Register User
              if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                if (await dbHelper.checkIfEmailAlreadyExists(
                    email: emailController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email already exists, login now!!"),backgroundColor: Colors.orange,));
                }else{
                  bool check = await dbHelper.registerUser(UserModel(
                      name: nameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                      createdAt: DateTime.now().millisecondsSinceEpoch.toString()
                  ));
                  if (check) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account registered successfully!!"),backgroundColor: Colors.green,));
                    Navigator.pop(context);
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to register, please try again!!"),backgroundColor: Colors.red,));
                  }
                }
              }else{
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all the required blanks!!"),backgroundColor: Colors.orange,));
              }

            },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffE78BBC),
                    elevation: 3,
                    shadowColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                child: const Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: Container(height: 1,color: Colors.grey,)),
                const SizedBox(width: 10,),
                const Text("Or sign up with",style: TextStyle(color:  Colors.grey,fontSize: 12),),
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
                    const Text("Already have an account?",style: TextStyle(color:  Colors.grey,fontSize: 14),),
                    const SizedBox(width: 5,),
                    InkWell(
                      child: const Text("Log in",style: TextStyle(color:Color(0xffE78BBC),fontSize: 14,fontWeight: FontWeight.bold)),
                      onTap: () {
                        Navigator.pop(context);
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
          color:  Color(0xffE78BBC),
          width: 2,
        )
    );
  }
}