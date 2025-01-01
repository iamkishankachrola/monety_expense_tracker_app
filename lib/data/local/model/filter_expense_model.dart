import 'package:monety_expense_tracker_app/data/local/model/expense_model.dart';

class FilterExpenseModel{
  String date;
  double totalAmount;
  List<ExpenseModel> allExpense;

  FilterExpenseModel({required this.date, required this.totalAmount, required this.allExpense});
}