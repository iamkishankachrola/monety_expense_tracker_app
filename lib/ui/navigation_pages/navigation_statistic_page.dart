import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationStatisticPage extends StatefulWidget{
  @override
  State<NavigationStatisticPage> createState() => _NavigationStatisticPageState();
}

class _NavigationStatisticPageState extends State<NavigationStatisticPage> {
  List<String> durationList = ["Today","This week","This month","This year" ];
  String selectedDuration = "This month";
  String selectedBreakdownDuration = "This week";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Statistic",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
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
                    value: selectedDuration,
                    items: durationList.map((element) => DropdownMenuItem(value: element,child: Text(element),)).toList(),
                    onChanged: (value) => setState(() {
                      selectedDuration = value!;
                    }),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20,),
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
                borderRadius:  BorderRadius.circular(10),
                color: const Color(0xff6574D3)
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total expense",style: TextStyle(fontSize: 14,color: Colors.white),),
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: const Color(0xff8490DC),
                        child: Image.asset("assets/images/option.png",width: 18,height:18,),
                      )
                    ],
                  ),
                  const Row(
                    children: [
                      Text("\$3,734",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),),
                      SizedBox(width: 10,),
                      Text("/ \$4000 per month",style: TextStyle(fontSize: 14,color:Color(0xffA7AEE4) ),)
                    ],
                  ),
                  LinearProgressIndicator(
                    backgroundColor: const Color(0xff5968BD),
                    color: const Color(0xffEBC68F),
                    borderRadius: BorderRadius.circular(10),
                    minHeight: 6,
                    value: 0.8,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Expense Breakdown",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  Text("Limit \$900 / week",style: TextStyle(fontSize: 14),)
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
                    value: selectedBreakdownDuration,
                    items: durationList.map((element) => DropdownMenuItem(value: element,child: Text(element),)).toList(),
                    onChanged: (value) => setState(() {
                      selectedBreakdownDuration = value!;
                    }),
                  ),
                ),
              )
            ],
          ),
          Image.asset("assets/images/expense_chart.jpg",width: double.infinity,height: 250,),
          const SizedBox(height: 10,),
          const Text("Spending Details",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
          const SizedBox(height: 5,),
          const Text("Your expenses are divided into 6 categories",style: TextStyle(fontSize: 14),),
          const SizedBox(height: 5,),
          Image.asset("assets/images/details_chart.jpg"),
          const SizedBox(height: 10,),
          SizedBox(
            width: double.infinity,
            height: 320,
            child: GridView.builder(gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 2/1,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),itemCount: 10,
              itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: const Color(0xffE0E9F7),width: 2)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xffE6E9F8)
                        ),
                        child: Image.asset("assets/images/shopping_cart.png"),
                      ),
                      const SizedBox(width: 15,),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20,),
                          Text("Shop",style: TextStyle(fontSize: 14),),
                          SizedBox(height: 5,),
                          Text("-\$1190",style: TextStyle(fontSize: 14,color: Color(0xffDB6565)),)
                        ],
                      )
                    ],
                  ),
                ),
              );
            },),
          )

        ],
      ),
    );
  }
}