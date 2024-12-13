import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationHomePage extends StatefulWidget{
  @override
  State<NavigationHomePage> createState() => _NavigationHomePageState();
}

class _NavigationHomePageState extends State<NavigationHomePage> {
List<String> durationList = ["Today","This week","This month","This year" ];
String selectedItem = "Today";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding:const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: Image.asset("assets/images/beard_man.png"),
                  ),
                  const SizedBox(width: 10,),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Morning",style: TextStyle(fontSize: 14,color: Colors.grey),),
                      Text("Virat",style: TextStyle(fontSize: 14),),
                    ],
                  ),
                ],
              ),
              Container(
                width: 120,
                height: 35,
                decoration: BoxDecoration(
                  color: const Color(0xffEFF1FD),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Center(
                  child: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 18,
                    iconEnabledColor: Colors.black,
                    underline: Container(height: 1,color: const Color(0xffEFF1FD),),
                    borderRadius: BorderRadius.circular(6),
                    value: selectedItem,
                    items: durationList.map((element) => DropdownMenuItem(value: element,child: Text(element),)).toList(),
                    onChanged: (value) => setState(() {
                    selectedItem = value!;
                  }),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20,),
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              borderRadius:  BorderRadius.circular(10),
              color: const Color(0xff6574D3)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(height: 20,),
                      const Text("Expense total",style: TextStyle(fontSize: 14,color: Colors.white),),
                      const SizedBox(height: 5,),
                      const Text("\$3,734",style: TextStyle(fontSize: 34,fontWeight: FontWeight.bold,color: Colors.white),),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xffDB6565)
                            ),
                            child: const Center(child: Text("+\$240",style: TextStyle(fontSize: 14,color: Colors.white),)),
                          ),
                          const SizedBox(width: 5,),
                          const Text("than last month",style: TextStyle(fontSize: 14,color: Colors.white),)
                        ],
                      ),
                      const SizedBox(height: 20,),
                    ],
                  ),
                  Image.asset("assets/images/expense_img.png",width: 170,height: 170,)
                ],
              ),
            ),
          ),
          const SizedBox(height: 20,),
          const Text("Expense List",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
         /* ListView.builder(itemCount:2,itemBuilder: (context, index) {
            return Flexible(child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tuesday, 14",style: TextStyle(fontSize: 14),),
                        Text("-\$1380",style: TextStyle(fontSize: 14),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 5,),
                    ListView.builder(itemCount:2,itemBuilder: (context, index) {
                      return ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xffE6E9F8)
                          ),
                          child: Image.asset("assets/images/shopping_cart.png"),
                        ),
                      );
                    },)
                  ],
                ),
              ),
            ));
          },)*/

        ],
      ),
    );
  }
}