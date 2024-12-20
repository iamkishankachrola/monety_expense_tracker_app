import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monety_expense_tracker_app/data/local/bloc/expense_event.dart';
import 'package:monety_expense_tracker_app/data/local/bloc/expense_state.dart';
import 'package:monety_expense_tracker_app/data/local/db_helper.dart';
import 'package:monety_expense_tracker_app/data/local/model/expense_model.dart';

class ExpenseBloc extends Bloc<ExpenseEvent,ExpenseState>{
  List<ExpenseModel> newExpenseList = [ ];
  DbHelper dbHelper = DbHelper.getInstance();
  ExpenseBloc() : super(ExpenseState(expenseList: [ ])){
    on<AddExpenseEvent>((event, emit) async{
      ExpenseModel expenseModel = event.expenseModel;
      bool check = await dbHelper.addExpense(expenseModel: expenseModel);
      if(check){
        newExpenseList =await dbHelper.fetchAllExpenseData();
        emit(ExpenseState(expenseList: newExpenseList));
      }
    },);

    on<GetAllExpenseEvent>((event, emit) async{
      newExpenseList = await dbHelper.fetchAllExpenseData();
      emit(ExpenseState(expenseList:newExpenseList));
    },);

  }
}