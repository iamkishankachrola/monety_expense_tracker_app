import 'package:monety_expense_tracker_app/data/local/db_helper.dart';

class UserModel{

  int? id;
  String name;
  String email;
  String password;
  String createdAt;

  UserModel({this.id,required this.name,required this.email, required this.password, required this.createdAt});

  factory UserModel.fromMap(Map<String,dynamic> map)=> UserModel(
          id : map[DbHelper.USER_COLUMN_ID],
          name: map[DbHelper.USER_COLUMN_NAME],
          email: map[DbHelper.USER_COLUMN_EMAIL],
          password: map[DbHelper.USER_COLUMN_PASSWORD],
          createdAt: map[DbHelper.USER_COLUMN_CREATED_AT]
  );

  Map<String,dynamic> toMap()=> {
      DbHelper.USER_COLUMN_NAME : name,
      DbHelper.USER_COLUMN_EMAIL : email,
      DbHelper.USER_COLUMN_PASSWORD : password,
      DbHelper.USER_COLUMN_CREATED_AT : createdAt,
    };

}