import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationHomePage extends StatefulWidget {
  @override
  State<NavigationHomePage> createState() => _NavigationHomePageState();
}

class _NavigationHomePageState extends State<NavigationHomePage> {
  List<String> durationList = ["Today", "This week", "This month", "This year"];
  String selectedItem = "This month";
    var itemsExpenseList = [

      {
        "img": "assets/images/shopping_cart.png",
        "title": "Shop",
        "description": "Buy new clothes",
        "amount": "-\$90",
      },
      {
        "img": "assets/images/shopping_cart.png",
        "title": "Electronic",
        "description": "Buy new iphone 14",
        "amount": "-\$1290",
      },


      {
        "img": "assets/images/shopping_cart.png",
        "title": "Transportation",
        "description": "Trip to Malang",
        "amount": "-\$60",
      },
      {
        "img": "assets/images/shopping_cart.png",
        "title": "Shop",
        "description": "Buy new shoes",
        "amount": "-\$100",
      },
  ];
    var daysExpenseList = [
      {
        "date": "Tuesday, 14",
        "totalAmount": "-\$1380",
      },
      {
        "date": "Monday, 13",
        "totalAmount": "-\$60",
      }
  ];

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
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: Image.asset("assets/images/beard_man.png"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Morning",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        "Virat",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: 120,
                height: 35,
                decoration: BoxDecoration(
                    color: const Color(0xffEFF1FD),
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 18,
                    iconEnabledColor: Colors.black,
                    underline: Container(
                      height: 1,
                      color: const Color(0xffEFF1FD),
                    ),
                    borderRadius: BorderRadius.circular(6),
                    value: selectedItem,
                    items: durationList
                        .map((element) => DropdownMenuItem(
                              value: element,
                              child: Text(element),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() {
                      selectedItem = value!;
                    }),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xff6574D3)),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Expense total",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "\$3,734",
                        style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 24,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xffDB6565)),
                            child: const Center(
                                child: Text(
                              "+\$240",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            )),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "than last month",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  Image.asset(
                    "assets/images/expense_img.png",
                    width: 170,
                    height: 170,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Expense List",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: double.infinity,
            height: 450,
            child: ListView.builder(
              itemCount: daysExpenseList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: const Color(0xffE0E9F7), width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  daysExpenseList[index]["date"].toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  daysExpenseList[index]["totalAmount"].toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              width: double.infinity,
                              height: 2,
                              color: const Color(0xffE0E9F7),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Flexible(
                            child: SizedBox(
                              width: double.infinity,
                              child: ListView.builder(
                                itemCount: itemsExpenseList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: const Color(0xffE6E9F8)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Image.asset(
                                          itemsExpenseList[index]["img"].toString(),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      itemsExpenseList[index]["title"].toString(),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    subtitle: Text(
                                      itemsExpenseList[index]
                                          ["description"].toString(),
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                    trailing: Text(
                                      itemsExpenseList[index]["amount"].toString(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xffDB6565)),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
