import 'package:projeto_final/model/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

  class ProductRepository{

    final String productTable = "product_table";
    final String idColumn = "id_column";
    final String nameColumn = "name_column";
    final String valueColumn = "value_column";
    final String cepColumn = "cep_column";

    Future<Database> initializeDB() async {
      final databasePath = await getDatabasesPath();
      final path = join(databasePath, "products.db");

      return openDatabase(path, version: 1,
          onCreate: (Database db, int newerVersion) async {
            await db.execute(
                "CREATE TABLE $productTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $valueColumn DOUBLE, $cepColumn INTEGER)"
            );
          }
      );
    }

    Future<int> save(Product product) async {
      final Database database = await initializeDB();
      return await database.insert(this.productTable, product.toMap()); //se salvou no banco ele retonar o numero de linhas afetadas
    }

    Future<List<Product>> fetchAll() async {
      final Database database = await initializeDB();
      final List<Map<String, Object>> query = await database.query(
          this.productTable,
          columns: [idColumn, nameColumn, valueColumn, cepColumn]
      );
      return query.map((element) => Product.fromMap(element)).toList();
    }

    Future<int> update(Product product) async {
      final Database database = await initializeDB();
      return await database.update(
          this.productTable,
          product.toMap(),
          where: '${this.idColumn} = ?',
          whereArgs: [product.id]
      );
    }

    Future<int> delete(Product product) async {
      final Database database = await initializeDB();
      return await database.delete(
          this.productTable,
          where: '${this.idColumn} = ?',
          whereArgs: [product.id]
      );
    }

  }