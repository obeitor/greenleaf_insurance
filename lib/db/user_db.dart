
import 'package:greenleaf_insurance/db/database.dart';

final String _table = "users";
final String _colId = "_id";
final String _colFname = "first_name";
final String _colLname = "last_name";
final String _colPassword = "password";
final String _colPhone = "phone";
final String _colTitle = "title";
final String _colEmail = "email";
final String _colGender = "gender";
final String _colAddress = "address";
final String _colNok = "nok_name";
final String _colNokPhone = "nok_phone";
final String _colNokEmail = "nok_email";
final String _colNokAddress = "nok_address";

class LocalUser{
  int _id = 0;
  String firstname = "";
  String lastname = "";
  String password = "";
  String phone = "";
  String title = "";
  String email = "";
  String gender = "";
  String houseAddress = "";
  String nokName = "";
  String nokPhone = "";
  String nokEmail = "";
  String nokAddress = "";

  bool exists() => _id>0;

  LocalUser();

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      _colId: this._id,
      _colFname: this.firstname,
      _colLname: this.lastname,
      _colEmail: this.email,
      _colGender: this.gender,
      _colTitle: this.title,
      _colPhone: this.phone,
      _colAddress: this.houseAddress,
      _colNok: this.nokName,
      _colNokAddress: this.nokAddress,
      _colNokEmail: this.nokEmail,
      _colNokPhone: this.nokPhone,
      _colPassword: this.password,
    };

  }
  LocalUser.fromMapDb(Map<String, dynamic> map){
    this._id = map[_colId];
    this.firstname = map[_colFname];
    this.lastname = map[_colLname];
    this.email = map[_colEmail];
    this.phone = map[_colPhone];
    this.title = map[_colTitle];
    this.houseAddress = map[_colAddress];
    this.gender = map[_colGender];
    this.nokPhone = map[_colNokPhone];
    this.nokName = map[_colNok];
    this.nokEmail = map[_colNokEmail];
    this.nokAddress = map[_colNokAddress];
    this.password = map[_colPassword];
  }
}

final LocalUserProvider userProvider = LocalUserProvider();
class LocalUserProvider{
  final String createString = '''CREATE TABLE $_table (
        $_colId integer primary key,
        $_colPassword text,
        $_colFname text,
        $_colLname text,
        $_colPhone text,
        $_colTitle text,
        $_colEmail text,
        $_colAddress text,
        $_colGender text,
        $_colNok text,
        $_colNokPhone text,
        $_colNokEmail text,
        $_colNokAddress text
        )''';

  Future<LocalUser> get()async{
    await dbProvider.checkOpen();
    List<Map<String,dynamic>>? maps = await dbProvider.db!.query(_table,
        columns: [_colId,_colFname,_colLname,_colPhone,_colEmail,_colTitle,
          _colAddress,_colGender,_colNokPhone,_colNok,_colNokEmail,_colNokAddress],
        where: '$_colId = ?',
        whereArgs: [1]
    );
    return  maps.isNotEmpty ? LocalUser.fromMapDb(maps.first) : LocalUser();
  }

  Future<bool> exists() async{
    await dbProvider.checkOpen();
    List<Map>? map =  await dbProvider.db?.query(_table, columns: [_colId]);
    return map!=null && map.length>0;
  }

  Future<LocalUser> save(LocalUser user)async{
    await dbProvider.checkOpen();
    if(await exists()){
      _update(user);
    }
    else{
      _create(user);
    }
    return user;
  }

  Future<LocalUser> _update(LocalUser user)async{
    await dbProvider.checkOpen();
    await dbProvider.db?.update(_table, user.toMap(), where: '$_colId = ?', whereArgs: [user._id]);
    return user;
  }

  Future<LocalUser> _create(LocalUser user)async{
    await dbProvider.checkOpen();
    user._id = 1;
    await dbProvider.db?.insert(_table, user.toMap());
    return user;
  }
}