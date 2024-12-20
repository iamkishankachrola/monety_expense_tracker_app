import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monety_expense_tracker_app/data/local/bloc/expense_bloc.dart';
import 'package:monety_expense_tracker_app/data/local/bloc/expense_event.dart';
import 'package:monety_expense_tracker_app/data/local/model/expense_model.dart';
import 'package:monety_expense_tracker_app/domain/app_constants.dart';
import 'package:monety_expense_tracker_app/ui/navigation_pages/navigation_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationAddExpensePage extends StatefulWidget {
  @override
  State<NavigationAddExpensePage> createState() => _NavigationAddExpensePageState();
}

class _NavigationAddExpensePageState extends State<NavigationAddExpensePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  List<String> expenseTypeList = ["Debit", "Credit", "Loan", "Lend", "Borrow"];
  String initialExpenseType = "Debit";
  int selectedCatIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Add Expense", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                const SizedBox(height: 40,),
                TextField(
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  cursorColor: const Color(0xffE78BBC),
                  decoration: InputDecoration(
                    enabledBorder: enableBorder(),
                    focusedBorder: focusedBorder(),
                    prefixIcon:
                        const Icon(Icons.title_outlined, color: Colors.grey),
                    hintText: "Enter your title",
                    hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20,),
                TextField(
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 3,
                  cursorColor: const Color(0xffE78BBC),
                  decoration: InputDecoration(
                    enabledBorder: enableBorder(),
                    focusedBorder: focusedBorder(),
                    prefixIcon: const Icon(Icons.description_outlined,
                        color: Colors.grey),
                    hintText: "Enter your description",
                    hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20,),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  cursorColor: const Color(0xffE78BBC),
                  decoration: InputDecoration(
                    enabledBorder: enableBorder(),
                    focusedBorder: focusedBorder(),
                    prefixIcon: const Icon(Icons.currency_rupee_outlined,
                        color: Colors.grey),
                    hintText: "Enter your amount",
                    hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20,),
                DropdownMenu(
                  width: double.infinity,
                  menuStyle: MenuStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                  ),
                  hintText: "Select expense type",
                  requestFocusOnTap: true,
                  leadingIcon: const Icon(Icons.credit_card),
                  inputDecorationTheme: InputDecorationTheme(
                    enabledBorder: enableBorder(),
                    focusedBorder: focusedBorder(),
                    focusColor: const Color(0xffE78BBC),
                    hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                    prefixIconColor: Colors.grey,
                  ),
                  dropdownMenuEntries: expenseTypeList.map((element) {
                    return DropdownMenuEntry(value: element, label: element);
                  }).toList(),
                  onSelected: (value) {
                    initialExpenseType = value!;
                  },
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(context: context, builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4),
                              itemCount: AppConstants.categoryList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    selectedCatIndex = index;
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(AppConstants.categoryList[index].imgPath, width: 40,height: 40,),
                                      const SizedBox(height: 5,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Center(child: Text(AppConstants.categoryList[index].name,maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffE78BBC),
                        elevation: 3,
                        shadowColor: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: selectedCatIndex >=0 ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppConstants.categoryList[selectedCatIndex].imgPath,width: 30,height: 30,),
                        Text(" - ${AppConstants.categoryList[selectedCatIndex].name}",style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)
                      ],
                    ) : const Center(child: Text("Choose a Category",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),)),
                const SizedBox(height: 20,),
                ElevatedButton(onPressed: () async{
                  if(titleController.text.isNotEmpty && descriptionController.text.isNotEmpty && amountController.text.isNotEmpty && selectedCatIndex >-1) {
                    SharedPreferences prefs =await SharedPreferences.getInstance();
                    String uId = prefs.getString("userId") ?? " ";
                    context.read<ExpenseBloc>().add(AddExpenseEvent(expenseModel: ExpenseModel(
                        userId: int.parse(uId),
                        title: titleController.text,
                        description: descriptionController.text,
                        expenseType: initialExpenseType,
                        amount: double.parse(amountController.text),
                        balance: 0,
                        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                        categoryId: AppConstants.categoryList[selectedCatIndex].id)));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Expense added successfully!!"),backgroundColor: Colors.green,));
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationHomePage(),));
                    }else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all required blanks!!"),backgroundColor: Colors.red,));
                  }
                },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffE78BBC),
                        elevation: 3,
                        shadowColor: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                    ),
                    child: const Text("Add Expense",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
              ],
            ),
          ),
        ));
  }

  OutlineInputBorder enableBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 2,
        ));
  }

  OutlineInputBorder focusedBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xffE78BBC),
          width: 2,
        ));
  }
}
