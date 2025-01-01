import 'package:monety_expense_tracker_app/data/local/model/expense_model.dart';

abstract class ExpenseState{}
class ExpenseInitialState extends ExpenseState{}
class ExpenseLoadingState extends ExpenseState{}
class ExpenseLoadedState extends ExpenseState{
  List<ExpenseModel> expenseList;
  ExpenseLoadedState({required this.expenseList});
}
class ExpenseErrorState extends ExpenseState{
  String errorMsg;
  ExpenseErrorState({required this.errorMsg});
}