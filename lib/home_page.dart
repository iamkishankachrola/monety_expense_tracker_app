import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monety_expense_tracker_app/navigation_pages/navigation_add_expense_page.dart';
import 'package:monety_expense_tracker_app/navigation_pages/navigation_home_page.dart';
import 'package:monety_expense_tracker_app/navigation_pages/navigation_statistic_page.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  List<Widget> navigationPage = [
    NavigationHomePage(),
    NavigationAddExpensePage(),
    NavigationStatisticPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Row(
          children: [
            Image.asset("assets/images/monety_logo.jpg",width: 30,height: 30,),
            Text("Monety",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
          ],
        ),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 20,)
        ],
        backgroundColor: Colors.white,
      ),
      body: navigationPage[selectedIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: Colors.white,
        onDestinationSelected: (value) {
          selectedIndex=value;
          setState(() {

          });
        },
        selectedIndex: selectedIndex,
        destinations:  [
        const NavigationDestination(icon: Icon(Icons.home_outlined,size:30,color: Colors.grey,), label: "",selectedIcon: Icon(Icons.home_outlined,size: 30,color:Color(0xffE78BBC),),),
        NavigationDestination(icon: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: const Color(0xffE78BBC),
            borderRadius: BorderRadius.circular(5)
          ),
          child: const Icon(Icons.add,size:30,color: Colors.white,),
        ), label: " ",selectedIcon: const Icon(Icons.add,size:30,color:Color(0xffE78BBC),),),
        const NavigationDestination(icon: Icon(Icons.bar_chart_outlined,color: Colors.grey,size:30), label: "",selectedIcon: Icon(Icons.bar_chart_outlined,color:Color(0xffE78BBC),size:30),),
      ],
      ),

    );
  }
}