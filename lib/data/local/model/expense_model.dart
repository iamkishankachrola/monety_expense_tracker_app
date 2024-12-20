import 'package:monety_expense_tracker_app/data/local/db_helper.dart';

class ExpenseModel {
    int? expenseId;
    int userId;
    String title;
    String description;
    String expenseType;
    double amount;
    double balance;
    String createdAt;
    int categoryId;

    ExpenseModel({this.expenseId,
        required this.userId,
        required this.title,
        required this.description,
        required this.expenseType,
        required this.amount,
        required this.balance,
        required this.createdAt,
        required this.categoryId});

    factory ExpenseModel.fromMap(Map<String, dynamic> map) =>
        ExpenseModel(
            expenseId: map[DbHelper.EXPENSE_COLUMN_ID],
            userId: map[DbHelper.EXPENSE_USER_ID],
            title: map[DbHelper.EXPENSE_COLUMN_TITLE],
            description: map[DbHelper.EXPENSE_COLUMN_DESCRIPTION],
            expenseType: map[DbHelper.EXPENSE_TYPE],
            amount: map[DbHelper.EXPENSE_COLUMN_AMOUNT],
            balance: map[DbHelper.EXPENSE_COLUMN_BALANCE],
            createdAt: map[DbHelper.EXPENSE_COLUMN_CREATED_AT],
            categoryId: map[DbHelper.EXPENSE_COLUMN_CATEGORY_ID]);


    Map<String, dynamic> toMap() =>
        {
            DbHelper.EXPENSE_USER_ID: userId,
            DbHelper.EXPENSE_COLUMN_TITLE: title,
            DbHelper.EXPENSE_COLUMN_DESCRIPTION: description,
            DbHelper.EXPENSE_TYPE: expenseType,
            DbHelper.EXPENSE_COLUMN_AMOUNT: amount,
            DbHelper.EXPENSE_COLUMN_BALANCE: balance,
            DbHelper.EXPENSE_COLUMN_CREATED_AT: createdAt,
            DbHelper.EXPENSE_COLUMN_CATEGORY_ID: categoryId,
        };

}
