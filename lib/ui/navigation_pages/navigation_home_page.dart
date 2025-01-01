import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:monety_expense_tracker_app/data/local/bloc/expense_bloc.dart';
import 'package:monety_expense_tracker_app/data/local/bloc/expense_event.dart';
import 'package:monety_expense_tracker_app/data/local/db_helper.dart';
import 'package:monety_expense_tracker_app/data/local/model/expense_model.dart';
import 'package:monety_expense_tracker_app/data/local/model/filter_expense_model.dart';
import 'package:monety_expense_tracker_app/domain/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/local/bloc/expense_state.dart';
import '../../data/local/model/user_model.dart';

class NavigationHomePage extends StatefulWidget {

  @override
  State<NavigationHomePage> createState() => _NavigationHomePageState();
}

class _NavigationHomePageState extends State<NavigationHomePage> {
  List<String> durationList = ["Date wise", "Month wise", "Year wise"];
  String selectedItem = "Date wise";
  String name = " ";
  List<FilterExpenseModel> filterData = [ ];
  DbHelper dbHelper = DbHelper.getInstance();
  DateFormat dateFormat = DateFormat.yMMMd();
  double balance=0;

    @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(GetAllExpenseEvent());
    getName();
  }

  void getName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("userName") ?? "User";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //   expenseList =context.watch<ExpenseBloc>().state.expenseList;
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
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Morning", style: TextStyle(fontSize: 14, color: Colors.grey),),
                      Text(name, style: const TextStyle(fontSize: 14),),
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
                              onTap: () {
                               setState(() {
                                 if(element == "Date wise"){
                                   dateFormat = DateFormat.yMMMd();
                                 }else if(element == "Month wise"){
                                   dateFormat = DateFormat.yMMMM();
                                 }else if(element == "Year wise"){
                                   dateFormat = DateFormat.y();
                                 }else{
                                   dateFormat = DateFormat.yMMMd();
                                 }
                               });
                              },
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
          const SizedBox(height: 20,),
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
                      const SizedBox(height: 20,),
                      const Text("Expense total", style: TextStyle(fontSize: 14, color: Colors.white),),
                      const SizedBox(height: 5,),
                      BlocBuilder<ExpenseBloc, ExpenseState>(builder: (context, state) {
                        if(state is ExpenseLoadedState) {
                          balance = getBalance(expenseList: state.expenseList);
                          return balance < 0 ? Text("-₹${-balance}", style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),)
                          : Text("+₹$balance", style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),);
                        }else{
                          return const Text(" ");
                        }
                      },),
                      const SizedBox(height: 5,),
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
                              "+₹240",
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
                      const SizedBox(height: 20,),
                    ],
                  ),
                  Image.asset("assets/images/expense_img.png", width: 170, height: 170,)
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
        BlocBuilder<ExpenseBloc, ExpenseState>(builder: (_, state){
        if(state is ExpenseLoadingState){
        return const Center(child: CircularProgressIndicator(),);
        } else if(state is ExpenseErrorState){
        return Center(child: Text(state.errorMsg),);
        } else if(state is ExpenseLoadedState) {
          filterDataDateWise(expenseList: state.expenseList);
          return filterData.isNotEmpty ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filterData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
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
                              Text((filterData[index].date),
                                style: const TextStyle(fontSize: 14,
                                    fontWeight: FontWeight.bold),),
                              Text(filterData[index].totalAmount>=0 ? "-₹${filterData[index].totalAmount.toString()}" : "+₹${(-filterData[index].totalAmount).toString()}" ,
                                style: const TextStyle(fontSize: 14,
                                    fontWeight: FontWeight.bold),)
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
                        ListView.builder(
                          itemCount: filterData[index].allExpense.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, childIndex) {
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
                                  child: Image.asset(AppConstants
                                      .categoryList[filterData[index].allExpense[childIndex]
                                      .categoryId - 1].imgPath),
                                ),
                              ),
                              title: Text(filterData[index].allExpense[childIndex].title,
                                style: const TextStyle(fontSize: 14),),
                              subtitle: Text(
                                filterData[index].allExpense[childIndex].description,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),),
                              trailing: filterData[index].allExpense[childIndex].expenseType ==
                                  "Credit" ?
                              Text("+₹${filterData[index].allExpense[childIndex].amount
                                  .toString()}", style: const TextStyle(
                                  fontSize: 14, color: Colors.green),)
                                  : Text("-₹${filterData[index].allExpense[childIndex].amount
                                  .toString()}", style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xffE78BBC)),),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ) : const SizedBox(
              width: double.infinity,
              height: 420,
              child: Center(child: Text("No expense yet!!",style: TextStyle(fontSize: 20),),));
        }else{
          return Container();
        }})
        ],
      ),
    );
  }

  void filterDataDateWise({required List<ExpenseModel> expenseList}){
      filterData.clear();
      List<String> uniqueDates = [ ];
      for(ExpenseModel eachExp in expenseList){
        String eachDate = dateFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.createdAt)));
        if(!uniqueDates.contains(eachDate)){
          uniqueDates.add(eachDate);
        }
      }
      for(String eachDate in uniqueDates){
        double totalAmount = 0;
        List<ExpenseModel> eachDateExp = [ ];
        for(ExpenseModel eachExp in expenseList){
              String expDate = dateFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.createdAt)));
              if(eachDate == expDate){
                eachDateExp.add(eachExp);
                if(eachExp.expenseType == "Debit"){
                  totalAmount = totalAmount + eachExp.amount;
                }else{
                  totalAmount = totalAmount - eachExp.amount;
                }
              }
        }
        filterData.add(FilterExpenseModel(date: eachDate, totalAmount: totalAmount, allExpense: eachDateExp));
      }
  }
  double getBalance({required List<ExpenseModel> expenseList}){
      double balance = 0;
      for(ExpenseModel expenseModel in expenseList){
        if(expenseModel.expenseType=="Debit"){
          balance = balance - expenseModel.balance;
        }else{
          balance = balance + expenseModel.balance;
        }
      }
      return balance;
  }
}
