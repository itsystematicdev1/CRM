import 'package:salesman/app/views/contacts/model/contact_info_model.dart';
import 'package:salesman/app/helper/log.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'abstract_database_class.dart';

class LostedCustomersDatabase extends DatabaseModule {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'losted_customers.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
     CREATE TABLE losted_customers(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        identification TEXT,
        name TEXT,
        phone TEXT,
        email TEXT,
        additionalInformation TEXT
      )
    ''');
    logError('Losted Customers Database created');
  }

  Future<int> insertLostedCustomer(ContactInfoModel customer) async {
    Database db = await database;
    int index = await db.insert('losted_customers', customer.toMap());
    logError('Losted Customer inserted at index $index');
    return index;
  }

  Future<int> editLostedCustomer(ContactInfoModel customer) async {
    Database db = await database;
    int result = await db.update(
      'losted_customers',
      customer.toMap(),
      where: 'id = ?',
      whereArgs: [customer.uId],
    );
    logError('Losted Customer edited with result $result');
    return result;
  }

  Future<int> removeLostedCustomer(int id) async {
    Database db = await database;
    int result =
        await db.delete('losted_customers', where: 'id = ?', whereArgs: [id]);
    logError('Losted Customer removed with result $result');
    return result;
  }

  @override
  Future<List<ContactInfoModel>> getAllContacts() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('losted_customers');
    List<ContactInfoModel> lostedCustomers =
        List.generate(maps.length, (index) {
      return ContactInfoModel(
        uId: maps[index]['id'],
        identification: maps[index]['identification'],
        name: maps[index]['name'],
        phone: maps[index]['phone'],
        email: maps[index]['email'],
        additionalInformation: maps[index]['additionalInformation'],
      );
    });
    logError('Fetched ${lostedCustomers.length} losted customers');
    return lostedCustomers;
  }
}
