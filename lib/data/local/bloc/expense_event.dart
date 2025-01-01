import 'package:monety_expense_tracker_app/data/local/model/expense_model.dart';

abstract class ExpenseEvent{}
class AddExpenseEvent extends ExpenseEvent{
  ExpenseModel expenseModel;
  AddExpenseEvent({required this.expenseModel});
}
class GetAllExpenseEvent extends ExpenseEvent{}
class FilterDataDateWiseEvent extends ExpenseEvent{
  List<ExpenseModel> expenseList;
  FilterDataDateWiseEvent({required this.expenseList});
}