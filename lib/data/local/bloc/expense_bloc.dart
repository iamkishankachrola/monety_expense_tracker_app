import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monety_expense_tracker_app/data/local/bloc/expense_event.dart';
import 'package:monety_expense_tracker_app/data/local/bloc/expense_state.dart';
import 'package:monety_expense_tracker_app/data/local/db_helper.dart';
import 'package:monety_expense_tracker_app/data/local/model/expense_model.dart';
import 'package:monety_expense_tracker_app/data/local/model/filter_expense_model.dart';

class ExpenseBloc extends Bloc<ExpenseEvent,ExpenseState>{
  List<ExpenseModel> newExpenseList = [ ];
  List<FilterExpenseModel> newFilterExpenseList= [ ];
  DbHelper dbHelper = DbHelper.getInstance();
  ExpenseBloc() : super(ExpenseInitialState()){
    on<AddExpenseEvent>((event, emit) async{
      emit(ExpenseLoadingState());
      ExpenseModel expenseModel = event.expenseModel;
      bool check = await dbHelper.addExpense(expenseModel: expenseModel);
      if(check){
        newExpenseList =await dbHelper.fetchAllExpenseData();
        emit(ExpenseLoadedState(expenseList: newExpenseList));
      }else{
        emit(ExpenseErrorState(errorMsg: "Expense cannot be added."));
      }
    },);

    on<GetAllExpenseEvent>((event, emit) async{
      emit(ExpenseLoadingState());
      newExpenseList = await dbHelper.fetchAllExpenseData();
      emit(ExpenseLoadedState(expenseList: newExpenseList));
    },);

    /*on<FilterDataDateWiseEvent>((event, emit) async{
      emit(ExpenseLoadingState());
        newFilterExpenseList =  dbHelper.filterDataDateWise(expenseList: event.expenseList);
        emit(ExpenseLoadedState(expenseList: newFilterExpenseList));
    },);*/

  }
}