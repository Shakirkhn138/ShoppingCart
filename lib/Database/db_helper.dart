import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

import '../Model/cart_model.dart';


class DBHelper{

  static Database? _db;

  Future<Database?> get db async {
    if( _db != null){
      return _db!;
    }

    _db = await initDatabase();
  }

  initDatabase()async{
    io.Directory loadDirectory = await getApplicationCacheDirectory();
    String path = join(loadDirectory.path, 'cart.db');
    var db = openDatabase(path, version: 1 , onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db , int version){
    db.execute(
        'CREATE TABLE cart(id INTEGER PRIMARY KEY , productId VARCHAR UNIQUE , productName  TEXT ,  initialPrice INTEGER, productPrice INTEGER, quantity INTEGER , unitTag TEXT , image TEXT)'
    );


  }

  Future<Cart> insert(Cart cart)async{
    var dbClient = await db;
    await dbClient?.insert('cart', cart.toMap());
    return cart;
  }

  // Future<List<Cart>> getCartList()async{
  //   var dbClient = await db;
  //   final List<Map<String , Object?>> queryResult = await dbClient!.query('cart');
  //   return queryResult.map((e) => Cart.fromMap(e)).toList();
  // }

  Future<List<Cart>> getCartList()async{
    var dbClient = await db;
    final List<Map<String , Object?>> queryResult = await dbClient!.query('cart');
    return queryResult.map((e) => Cart.fromMap(e)).toList();
  }
  Future<int> delete(int id)async{
    var dbClient = await db;
    return await dbClient!.delete(
      'cart',
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  Future<int> updateQuantity(Cart cart)async{
    var dbClient = await db;
    return await dbClient!.update(
        'cart',
        cart.toMap(),
        where: 'id = ?',
        whereArgs: [cart.id]
    );
  }

}


// class DBHelpler{
//
//   static Database? _db;
//
//   Future<Database?> get db async{
//     for(_db != null){
//       return _db!;
//     }
//
//     _db = await initDatabase();
//
//   }
//
//   initDatabase()async{
//     io.Directory loadDirectory = await getApplicationCacheDirectory();
//     String path = join(loadDirectory.path , 'cart.db');
//     var db = await openDatabase(path , version: 1 , onCreate: _onCreate);
//   }
//
//   _onCreate(Database db , int version){
//     db.execute(
//         'CREATE TABLE cart(id INTEGER PRIMARY KEY, productId VARCHAR UNIQUE , productName  TEXT ,  initialPrice INTEGER, productPrice INTEGER, quantity INTEGER , unitTag TEXT , image TEXT)'
//     );
//   }
//
//   Future<Cart> inset(Cart cart)async{
//     var dbClient = await db;
//     await dbClient?.insert('cart' , cart.toMap());
//     return cart;
//   }
//
// }



// class DBHelper{
//
//   static Database? _db;
//
//   Future<Database?> get db async {
//     if(_db != null){
//       return _db!;
//     }
//
//     _db = await initDatabase();
//
//   }
//
//   initDatabase()async{
//     io.Directory documentDirectory = await getApplicationCacheDirectory();
//     String path = join(documentDirectory.path, 'cart.db');
//     var db = await openDatabase(path , version: 1 , onCreate: _onCreate);
//     return db;
//   }
//
//   _onCreate(Database db , int version){
//     db.execute(
//       'CREATE TABLE cart(id INTEGER PRIMARY KEY, productId VARCHAR UNIQUE , productName  TEXT ,  initialPrice INTEGER, productPrice INTEGER, quantity INTEGER , unitTag TEXT , image TEXT)'
//     );
//
//     Future<Cart> insert(Cart cart) async {
//       var dbClient = await db;
//       await dbClient.insert('cart' , cart.toMap());
//       return cart;
//     }
//
//   }
//
// }
// Second try
// class DBHelper {
//
//   static Database? _db;
//
//   Future<Database?> get db async {
//     if( _db != null){
//       return _db!;
//     }
//
//     _db = await initDatabase();
//
//   }
//
//   initDatabase()async{
//     io.Directory loadDirectory = await getApplicationCacheDirectory();
//     String path = join(loadDirectory.path , 'cart.db');
//     var db = await openDatabase(path , version: 1 , onCreate: _onCreate);
//   }
//
//   _onCreate(Database db , int version){
//     db.execute(
//         'CREATE TABLE cart(id INTEGER PRIMARY KEY, productId VARCHAR UNIQUE , productName  TEXT ,  initialPrice INTEGER, productPrice INTEGER, quantity INTEGER , unitTag TEXT , image TEXT)'
//     );
//   }
//
//   Future<Cart> inset(Cart cart) async {
//     var dbClient = await db;
//     await dbClient?.insert('cart', cart.toMap());
//     return cart;
//   }
//
// }

// Third Try

// class DBHelper{
//
//   static Database? _db;
//
//   Future<Database?> get db async {
//     if( _db != null){
//       return _db!;
//     }
//
//     _db = await initDatabase();
//
//   }
//
//   initDatabase()async{
//     io.Directory loadDirectory = await getApplicationCacheDirectory();
//     String path = join(loadDirectory.path , 'cart.db');
//     var db = await openDatabase(path , version: 1 , onCreate: _onCreate);
//     return db;
//   }
//
//   _onCreate(Database db , int version){
//     db.execute(
//         'CREATE TABLE cart(id INTEGER PRIMARY KEY, productId VARCHAR UNIQUE , productName  TEXT ,  initialPrice INTEGER, productPrice INTEGER, quantity INTEGER , unitTag TEXT , image TEXT)'
//     );
//   }
//
//
//   Future<Cart> insert(Cart cart)async{
//     var dbClient = await db;
//     await dbClient?.insert('cart', cart.toMap());
//     return cart;
//   }
//
// }


//Fourth Try

