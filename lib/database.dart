import 'package:bitetime/common_files/logger_print.dart';
import 'package:bitetime/model/data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "card.db";
  static final _databaseVersion = 1;

  static final table = 'cars_table1';

  //pid, pnode, title, productType, description, image, qty, variants_id, variants_price, variants_title, total_price
  static final columnId = 'ids'; // pid
  static final columnNamed = 'name'; // pnode
  static final columnMiles = 'miles';
  static final columnPId = 'pid';
  static final columnTitle = 'title';
  static final columnProductType = 'productType';
  static final columnDecription = 'description';
  static final columnImage = 'image';
  static final columnQty = 'qty';
  static final columnVId = 'variants_id';
  static final columnVPrice = 'variants_price';
  static final columnVTitle = 'variants_title';
  static final columnTotalPrice = 'total_price';
  static final columnVSauce = 'sauce';
  static final columnVSide = 'side';
  //----Add Extra
  // static final columnAddExtraTitle = 'add_extra_title';
  // static final columnAddExtraPrice = 'add_extra_price';
  // static final columnAddExtraImage = 'add_extra_image';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    // ignore: unnecessary_null_comparison
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnNamed TEXT NULL,
            $columnMiles INTEGER NULL,
            $columnPId TEXT NULL,
            $columnTitle TEXT NULL,
            $columnProductType TEXT NULL,
            $columnDecription TEXT NULL,
            $columnImage TEXT NULL,
            $columnQty TEXT NULL,
            $columnVId TEXT NULL,
            $columnVPrice TEXT NULL,
            $columnVTitle TEXT NULL,
            $columnTotalPrice TEXT NULL,
            $columnVSauce TEXT NULL,
            $columnVSide TEXT NULL)
          ''');
    print('category created! ----------BiteTime');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Car car) async {
    Database db = await instance.database;
    print(car.variantsTitle);
    //pid, pnode, title, productType, description, image, qty, variants_id, variants_price,
    //variants_title, total_price

    var dbData = await db.insert(table, {
      'name': car.name,
      'miles': car.miles,
      'pid': car.pid,
      'title': car.title,
      'productType': car.productType,
      'description': car.description,
      'image': car.image,
      'qty': car.qty,
      'variants_id': car.variantId,
      'variants_price': car.variantsPrice,
      'variants_title': car.variantsTitle,
      'total_price': car.totalPrice,
      'sauce': car.sauce,
      'side': car.side
    });
    print("########################################### BiteTime Insert ");
    CommonFunctions().console(dbData);
    return dbData;
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // Queries rows based on the argument received
  Future<List<Map<String, dynamic>>> queryRows(name) async {
    Database db = await instance.database;
    return await db.query(table, where: "$columnNamed LIKE '%$name%'");
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT FROM $table name'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Car car) async {
    Database db = await instance.database;
    int pid = car.toMap()['id']; //id
    return await db
        .update(table, car.toMap(), where: '$columnId = ?', whereArgs: [pid]);
  }

  Future<int> updateQtyAndPrice(id, String qty, String totalPrice) async {
    Database db = await instance.database;
    Map<String, dynamic> row = {
      DatabaseHelper.columnQty: qty,
      DatabaseHelper.columnTotalPrice: totalPrice
    };
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // updateClient(Car car) async {
  //  Database db = await instance.database;
  //int id = car.toMap()['id']; //id
  //return await db
  //   .update(table, car.toMap(), where: '$columnPId = ?', whereArgs: [id]);
  // }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteLoginData() async {
    // ignore: await_only_futures
    var dbClient = await _database;
    return await dbClient.delete('User', where: "id = ?", whereArgs: [1]);
    //return await dbClient.delete('$table');
  }

  Future<int> deleteBYProductId(String vPid) async {
    Database db = await instance.database;
    return await db.delete(table, where: 'pid = ?', whereArgs: [vPid]);
  }

  isRecordExists(String vPid) async {
    Database db = await instance.database;
    var result = await db.query(table, where: 'pid = ?', whereArgs: [vPid]);
    if (result.length > 0) {
      await db.delete(table, where: 'ids = ?', whereArgs: [result[0]['ids']]);
    }
    return result.length > 0 ? true : false;
  }

  getSauceIfProductExists(String vPid) async {
    Database db = await instance.database;
    var result = await db.query(table, where: 'pid = ?', whereArgs: [vPid]);
    if (result.length > 0) {
      print('SAUCE_SAUCE...${result[0]['sauce']}');
      var kkk = result[0]['sauce'];
      print('SAUCE_SAUCE_KKK...$kkk');
      return kkk;
    } else {
      return '';
    }
    //return result.length > 0 ? true : false;
  }

  getSauceIfProductExistsTwo(String vPid) async {
    Database db = await instance.database;
    var result = await db.query(table, where: 'pid = ?', whereArgs: [vPid]);
    if (result.length > 0) {
      print('SAUCE_SAUCE...${result[0]['side']}');
      return result[0]['side'];
    } else {
      return '';
    }
    //return result.length > 0 ? true : false;
  }

  isDessertsExists(String vPid, String vVariantPrice) async {
    Database db = await instance.database;
    var result = await db.query(table, where: 'pid = ?', whereArgs: [vPid]);
    if (result.length > 0) {
      // update qty & price
      int qty = int.parse(result[0]['qty']) + 1;

      String dessertTotalPrice = (double.parse(result[0]['variants_price']) +
              double.parse(vVariantPrice))
          .toStringAsFixed(2);

      Map<String, dynamic> row = {
        DatabaseHelper.columnQty: qty.toString(),
        DatabaseHelper.columnTotalPrice: dessertTotalPrice
      };
      int res = await db.update(table, row,
          where: '$columnId = ?', whereArgs: [result[0]['ids']]);
      print("Dessert updated....$res");
    }
    return result.length > 0 ? true : false;
  }

  Future<List<Map<String, dynamic>>> isRecordExist(id) async {
    Database db = await instance.database;
//String sql = "SELECT * FROM brand WHERE brand_id='" + brand_id + "'";
    var qry =
        "SELECT * FROM cars_table1 WHERE pid = Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0LzU2Njg5MTUyNDkzMDI=";
    // return await db.query("SELECT * FROM cars_table1 WHERE $columnPId = '$id'");
    return await db.query(qry);
  }

  Future<List<Map<String, Object>>> getProductById(String id) async {
    Database db = await instance.database;
    var result =
        await db.query("cars_table1", where: "pid = ?", whereArgs: [id]);
    return result.isNotEmpty ? result : Null;
  }
}
