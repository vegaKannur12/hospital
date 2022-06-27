// ignore_for_file: unused_local_variable

import 'dart:ffi';
import 'package:hospital/MODEL/getRegistration_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class OrderAppDB {
  DateTime date = DateTime.now();
  String? formattedDate;
  var aidsplit;
  String? areaidfromStaff;
  static final OrderAppDB instance = OrderAppDB._init();
  static Database? _database;
  OrderAppDB._init();
  /////////registration fields//////////
  static final id = 'id';
  static final cid = 'cid';
  static final fp = 'fp';
  static final os = 'os';
  static final c_d = 'c_d';
  static final cpre = 'cpre';
  static final ctype = 'ctype';
  static final hoid = 'hoid';
  static final cnme = 'cnme';
  static final ad1 = 'ad1';
  static final ad2 = 'ad2';
  static final pcode = 'pcode';
  static final ad3 = 'ad3';
  static final land = 'land';
  static final mob = 'mob';
  static final em = 'em';
  static final gst = 'gst';
  static final ccode = 'ccode';
  static final scode = 'scode';
  static final msg = 'msg';

/////////// staff details /////////////
  static final sid = 'sid';
  static final sname = 'sname';
  static final uname = 'uname';
  static final pwd = 'pwd';
  static final ph = 'ph';
  static final area = 'area';
  static final datetime = 'datetime';
  static final base_url = 'base_url';

  // int DB_VERSION = 2;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("hospitalapp.db");
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);
    return await openDatabase(
      path,
      version: 1, onCreate: _createDB,
      // onUpgrade: _upgradeDB
    );
  }

  Future _createDB(Database db, int version) async {
    print("table created");
    ///////////////orderapp store table ////////////////
    await db.execute('''
          CREATE TABLE registrationTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $cid TEXT NOT NULL,
            $fp TEXT NOT NULL,
            $os TEXT NOT NULL,
            $cpre TEXT,
            $ctype TEXT,
            $cnme TEXT,
            $ad1 TEXT,
            $ad2 TEXT,
            $ad3 TEXT,
            $pcode TEXT,
            $land TEXT,
            $mob TEXT,
            $em TEXT,
            $gst TEXT,
            $ccode TEXT,
            $scode TEXT,
            $base_url TEXT,
            $msg TEXT
          )
          ''');
  }

  ////////////////////////company details select///////////////////////////////////
  selectCompany(String cid) async {
    List result;
    Database db = await instance.database;

    result = await db
        .rawQuery('select cnme from registrationTable where cid = "$cid"');
    // print("select * from registrationTable where $condition");
    print("company deta-=-$result");
    if (result.length > 0) {
      return result;
    } else {
      return null;
    }
  }

  ///////////////////// registration details insertion //////////////////////////
  Future insertRegistrationDetails(GetRegistrationData data) async {
    final db = await database;
    var query1 =
        'INSERT INTO registrationTable(cid, fp, os, cpre, ctype, cnme, ad1, ad2, ad3, pcode, land, mob, em, gst, ccode, scode, base_url, msg) VALUES("${data.cid}", "${data.fp}", "${data.os}","${data.c_d![0].cpre}", "${data.c_d![0].ctype}", "${data.c_d![0].cnme}", "${data.c_d![0].ad1}", "${data.c_d![0].ad2}", "${data.c_d![0].ad3}", "${data.c_d![0].pcode}", "${data.c_d![0].land}", "${data.c_d![0].mob}", "${data.c_d![0].em}", "${data.c_d![0].gst}", "${data.c_d![0].ccode}", "${data.c_d![0].scode}", "${data.c_d![0].base_url}", "${data.msg}" )';
    var res = await db.rawInsert(query1);
    // print(query1);
    print(res);
    return res;
  }
}  

//////////////////////////////////////////////////////////////
