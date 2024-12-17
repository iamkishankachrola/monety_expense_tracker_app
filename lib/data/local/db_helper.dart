import 'package:monety_expense_tracker_app/data/local/model/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  DbHelper._();

  static DbHelper getInstance() => DbHelper._();

  Database? myDB;

  static const String TABLE_USER = "user";
  static const String USER_COLUMN_ID = "u_id";
  static const String USER_COLUMN_NAME = "u_name";
  static const String USER_COLUMN_PASSWORD = "u_password";
  static const String USER_COLUMN_EMAIL = "u_email";
  static const String USER_COLUMN_CREATED_AT = "u_created_at";

  static const String TABLE_EXPENSE = "expense";
  static const String EXPENSE_COLUMN_ID = "e_id";
  static const String EXPENSE_USER_ID = "u_id";
  static const String EXPENSE_COLUMN_TITLE = "e_title";
  static const String EXPENSE_COLUMN_DESCRIPTION= "e_description";
  static const String EXPENSE_TYPE_CREDIT = "e_credit";
  static const String EXPENSE_TYPE_DEBIT = "e_debit";
  static const String EXPENSE_COLUMN_AMOUNT = "e_amount";
  static const String EXPENSE_COLUMN_BALANCE = "e_balance";

  Future<Database> initDB() async{
    myDB = myDB ?? await openDB();
    print("DB : Open db!!");
    return myDB!;
  }

  Future<Database> openDB() async{
    var dirPath = await getApplicationDocumentsDirectory();
    var dbPath = join(dirPath.path,"expenseDB.db");

    return openDatabase(dbPath, version: 1, onCreate: (db, version) {
      print("DB : create db!!");
      db.execute("create table $TABLE_USER ( $USER_COLUMN_ID integer primary key autoincrement, $USER_COLUMN_NAME text, $USER_COLUMN_EMAIL text,  $USER_COLUMN_PASSWORD text, $USER_COLUMN_CREATED_AT text )");
      db.execute("create table $TABLE_EXPENSE ( $EXPENSE_COLUMN_ID integer primary key autoincrement, $EXPENSE_USER_ID integer, $EXPENSE_COLUMN_TITLE text, $EXPENSE_COLUMN_DESCRIPTION text, $EXPENSE_TYPE_CREDIT integer, $EXPENSE_TYPE_DEBIT integer, $EXPENSE_COLUMN_AMOUNT integer, $EXPENSE_COLUMN_BALANCE integer)");
    },);
  }
  Future<bool> checkIfEmailAlreadyExists({required String email}) async{
    Database db = await initDB();
    List<Map<String,dynamic>> data = await db.query(TABLE_USER, where: "$USER_COLUMN_EMAIL = ?" , whereArgs: [email]);
    return data.isNotEmpty;
  }

  Future<bool> registerUser(UserModel userModel) async{
    Database db = await initDB();
    int rowsEffected = await db.insert(TABLE_USER, userModel.toMap());
    return rowsEffected>0;
  }

  Future<bool> authenticateUser({required String email, required String password}) async{
    Database db = await initDB();
    List<Map<String,dynamic>> data = await db.query(TABLE_USER, where: "$USER_COLUMN_EMAIL = ? AND $USER_COLUMN_PASSWORD = ?", whereArgs: [email,password]);
    /// saving user in prefs
    if(data.isNotEmpty){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("userId", data[0][USER_COLUMN_ID].toString());
    }
    return data.isNotEmpty;
  }

  Future<List<UserModel>> fetchAllData() async{
    Database db = await initDB();
    List<UserModel> userList = [ ];
    List<Map<String,dynamic>> allNotes = await db.query(TABLE_USER);
    for(Map<String,dynamic> eachData in allNotes){
      UserModel eachUser = UserModel.fromMap(eachData);
      userList.add(eachUser);
    }
    return userList;
  }

  /*Future<bool> updateData(UserModel userModel) async{
    Database db = await initDB();
    int rowsEffected = await db.update(TABLE_USER,userModel.toMap(), where: "$USER_COLUMN_ID= ${userModel.id}");
    return rowsEffected>0;
  }

  Future<bool> deleteData({required int id}) async{
    Database db = await initDB();
    int rowsEffected = await db.delete(TABLE_USER,where: "$USER_COLUMN_ID = $id" );
    return rowsEffected>0;
  }*/

}