
import 'dart:async';
import 'dart:core';
import 'package:greenleaf_insurance/db/user_db.dart';
import 'package:path/path.dart' as Path;

import 'package:sqflite/sqflite.dart';



final DatabaseProvider dbProvider = DatabaseProvider();

class DatabaseProvider{
  Database? db;
  open() async{
    String dbPath = await getDatabasesPath();
    db = await openDatabase( Path.join(dbPath,'greenleaf_temp.db'),
        version: 1,
        onCreate: (Database db, int version) async{
          await db.execute(LocalUserProvider().createString);
        }
    );
  }

  checkOpen() async{
    if(db==null){
      await open();
    }
  }
}
