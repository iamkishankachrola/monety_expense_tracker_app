import 'package:d_chart/d_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:monety_expense_tracker_app/data/local/model/expense_model.dart';
import 'package:monety_expense_tracker_app/data/local/model/filter_category_model.dart';
import 'package:monety_expense_tracker_app/data/local/model/filter_expense_model.dart';
import 'package:monety_expense_tracker_app/domain/app_constants.dart';
import '../../data/local/bloc/expense_bloc.dart';
import '../../data/local/bloc/expense_state.dart';

class NavigationStatisticPage extends StatefulWidget {
  @override
  State<NavigationStatisticPage> createState() =>
      _NavigationStatisticPageState();
}

class _NavigationStatisticPageState extends State<NavigationStatisticPage> {
  List<String> durationList = ["Date wise", "Month wise", "Year wise"];
  String selectedDuration = "Date wise";
  String selectedBreakdownDuration = "Date wise";
  List<FilterCategoryModel> filterCategoryData = [];
  List<FilterExpenseModel> filterExpenseData = [];
  DateFormat dateFormat = DateFormat.d();
  String limitedAmount = "Limit ₹2,000 / day";
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
              const Text(
                "Statistic",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
                    value: selectedDuration,
                    items: durationList
                        .map((element) => DropdownMenuItem(
                              value: element,
                              child: Text(element),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() {
                      selectedDuration = value!;
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
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xff6574D3)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total expense",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: const Color(0xff8490DC),
                        child: Image.asset(
                          "assets/images/option.png",
                          width: 18,
                          height: 18,
                        ),
                      )
                    ],
                  ),
                  const Row(
                    children: [
                      Text(
                        "₹3,734",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "/ ₹4000 per month",
                        style:
                            TextStyle(fontSize: 14, color: Color(0xffA7AEE4)),
                      )
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
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Expense Breakdown", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5,),
                  Text(limitedAmount, style: const TextStyle(fontSize: 14),)
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
                    value: selectedBreakdownDuration,
                    items: durationList
                        .map((element) => DropdownMenuItem(
                              value: element,
                              child: Text(element),
                              onTap: (){
                                setState(() {
                                  if(element == "Date wise"){
                                    dateFormat = DateFormat.d();
                                    limitedAmount = "Limit ₹2,000 / day";
                                  }else if(element == "Month wise"){
                                    dateFormat = DateFormat.yM();
                                    limitedAmount = "Limit ₹10,000 / week";
                                  }else if(element == "Year wise"){
                                    dateFormat = DateFormat.y();
                                    limitedAmount = "Limit ₹1,00,000 / year";
                                  }else{
                                    dateFormat = DateFormat.d();
                                    limitedAmount = "Limit ₹2,000 / day";
                                  }
                                });
                              },
                            ))
                        .toList(),
                    onChanged: (value) => setState(() {
                      selectedBreakdownDuration = value!;
                    }),
                  ),
                ),
              )
            ],
          ),
          BlocBuilder<ExpenseBloc, ExpenseState>(builder: (_, state) {
            if (state is ExpenseLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ExpenseErrorState) {
              return Center(
                child: Text(state.errorMsg),
              );
            } else if (state is ExpenseLoadedState) {
              filterDataDateWise(expenseList: state.expenseList);
              List<OrdinalData> myData = [];
              double highestAmount = 0;
              for (FilterExpenseModel eachFilterData in filterExpenseData) {
                if(highestAmount<eachFilterData.totalAmount){
                  highestAmount = eachFilterData.totalAmount;
                }
                myData.add(OrdinalData(domain: eachFilterData.date, measure:eachFilterData.totalAmount));
              }
              return filterExpenseData.isNotEmpty
                  ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: DChartBarO(
                            fillColor: (group, ordinalData, index) {
                              return ordinalData.measure==highestAmount ? const Color(0xffDB6565) : const Color(0xff66C2DB);
                            },
                            configRenderBar: const ConfigRenderBar(radius: 3),
                            domainAxis: const DomainAxis(gapAxisToLabel: 4),
                            groupList: [OrdinalGroup(id: "1", data: myData)]
                        ),
                      ),
                  )
                  : const SizedBox(
                      width: double.infinity,
                      height: 250,
                      child: Center(
                        child: Text(
                          "No expense yet!!",
                          style: TextStyle(fontSize: 20),
                        ),
                      ));
            } else {
              return Container();
            }
          }),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Spending Details",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
           const Text(
            "Your expenses are divided into 14 categories",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(
            height: 5,
          ),
          Image.asset("assets/images/details_chart.jpg"),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<ExpenseBloc, ExpenseState>(builder: (_, state) {
            if (state is ExpenseLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ExpenseErrorState) {
              return Center(
                child: Text(state.errorMsg),
              );
            } else if (state is ExpenseLoadedState) {
              filterDataCategoryWise(expenseList: state.expenseList);
              return filterCategoryData.isNotEmpty
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 2 / 1,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      itemCount: filterCategoryData.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color(0xffE0E9F7), width: 2)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,right:5),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color(0xffE6E9F8)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(AppConstants
                                        .categoryList[filterCategoryData[index]
                                                .categoryId -
                                            1]
                                        .imgPath),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      filterCategoryData[index].title,maxLines: 1,overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    filterCategoryData[index].expenseType ==
                                            "Credit"
                                        ? Text(
                                            "+₹${filterCategoryData[index].totalAmount.toString()}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.green),
                                          )
                                        : Text(
                                            "-₹${filterCategoryData[index].totalAmount.toString()}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xffE78BBC)),
                                          ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Center(
                        child: Text(
                          "No expense yet!!",
                          style: TextStyle(fontSize: 20),
                        ),
                      ));
            } else {
              return Container();
            }
          })
          /*SizedBox(
            width: double.infinity,
            height: 320,
            child:
          )*/
        ],
      ),
    );
  }

  void filterDataCategoryWise({required List<ExpenseModel> expenseList}) {
    filterCategoryData.clear();
    List<int> uniqueId = [];
    for (ExpenseModel eachExp in expenseList) {
      int eachId = eachExp.categoryId;
      if (!uniqueId.contains(eachId)) {
        uniqueId.add(eachId);
      }
    }
    for (int eachId in uniqueId) {
      double totalAmount = 0;
      String title = " ";
      String expenseType = " ";
      for (ExpenseModel eachExp in expenseList) {
        int expId = eachExp.categoryId;
        if (eachId == expId) {
          title = eachExp.title;
          expenseType = eachExp.expenseType;
          totalAmount = totalAmount + eachExp.amount;
        }
      }
      filterCategoryData.add(FilterCategoryModel(
          categoryId: eachId,
          title: title,
          totalAmount: totalAmount,
          expenseType: expenseType));
    }
  }

  void filterDataDateWise({required List<ExpenseModel> expenseList}) {
    filterExpenseData.clear();
    List<String> uniqueDates = [];
    for (ExpenseModel eachExp in expenseList) {
      String eachDate = dateFormat.format(
          DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.createdAt)));
      if (!uniqueDates.contains(eachDate)) {
        uniqueDates.add(eachDate);
      }
    }
    for (String eachDate in uniqueDates) {
      double totalAmount = 0;
      List<ExpenseModel> eachDateExp = [];
      for (ExpenseModel eachExp in expenseList) {
        String expDate = dateFormat.format(
            DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.createdAt)));
        if (eachDate == expDate) {
          eachDateExp.add(eachExp);
          if (eachExp.expenseType == "Debit") {
            totalAmount = totalAmount + eachExp.amount;
          } /*else {
            totalAmount = totalAmount - eachExp.amount;
          }*/
        }
      }
      filterExpenseData.add(FilterExpenseModel(
          date: eachDate, totalAmount: totalAmount, allExpense: eachDateExp));
    }
  }
}
