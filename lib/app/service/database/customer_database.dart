import 'package:salesman/app/views/contacts/model/contact_info_model.dart';
import 'package:salesman/app/helper/log.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'abstract_database_class.dart';

class CustomersDatabase extends DatabaseModule {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'customers.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
     CREATE TABLE customers(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        identification TEXT,
        name TEXT,
        phone TEXT,
        email TEXT,
        additionalInformation TEXT
      )
    ''');
    logError('Database created');
  }

  Future<int> insertCustomer(ContactInfoModel customer) async {
    Database db = await database;
    int index = await db.insert('customers', customer.toMap());
    logError('Customer inserted at index $index');
    return index;
  }

  Future<int> editCustomer(ContactInfoModel customer) async {
    Database db = await database;
    int result = await db.update(
      'customers',
      customer.toMap(),
      where: 'id = ?',
      whereArgs: [customer.uId],
    );
    logError('Customer edited with result $result');
    return result;
  }

  Future<int> removeCustomer(int id) async {
    Database db = await database;
    int result = await db.delete('customers', where: 'id = ?', whereArgs: [id]);
    logError('Customer removed with result $result');
    return result;
  }

  @override
  Future<List<ContactInfoModel>> getAllContacts() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('customers');
    List<ContactInfoModel> customers = List.generate(maps.length, (index) {
      return ContactInfoModel(
        uId: maps[index]['id'],
        identification: maps[index]['identification'],
        name: maps[index]['name'],
        phone: maps[index]['phone'],
        email: maps[index]['email'],
        additionalInformation: maps[index]['additionalInformation'],
      );
    });
    logError('Fetched ${customers.length} customers');
    return customers;
  }
}
