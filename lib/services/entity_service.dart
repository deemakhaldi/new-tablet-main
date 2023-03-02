import 'dart:convert';

import 'package:new_tablet/locator.dart';
import 'package:new_tablet/models/base_model.dart';
import 'package:new_tablet/models/contact_model.dart';
import 'package:new_tablet/models/item_model.dart';
import 'package:new_tablet/services/api_service.dart';
import 'package:new_tablet/services/database_service.dart';
import 'package:new_tablet/services/items_service.dart';
import 'package:new_tablet/services/localization_service.dart';

class EntityService<T> {
  String tableName = '';
  String apiComponent = '';
  List<String> columns = [];
  List<dynamic> filters = [];

  get({online}) async {
    try {
      if (online) {
        var params = {'columns': columns, 'filters': filters};

        String url = tableName;

        List<T> list = [];
        List<T> response =
            await locator.get<ApiBaseHelper>().get(tableName, columns);

        // for (var item in response['rows']) {
        //   Map<String, dynamic> map = item;
        //   list.add(ItemModel.fromJson(map));
        // }

        // await locator.get<DatabaseHelper>().saveTableData(list);

        return response;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<List<dynamic>> getList<T>() async {
    try {
      // var map = new Map<String, dynamic>();
      // map["action"] = "fetch-all";
      // final response = await http.post(ROOT, body: map);
      var params = {'columns': columns, 'filters': filters};

      List<dynamic> list = [];
      final response =
          await locator.get<ApiBaseHelper>().get(apiComponent, columns);

      // for (var item in response['rows']) {
      //   var x = unmarshal(item, type: T);
      //   list.add(x);
      // }

      // final parsed = jsonDecode(response['rows']).cast<Map<String, dynamic>>();
      // print(parsed);
      // List<IBaseModel> listToSave = list.map<IBaseModel>((json) {
      //   // Map x = unmarshalTojson(json, type: T);
      //   return json.values;
      // }).toList();

      // List<T> listFinal = await dbHelper.getTableData();
      print('listFinal-->$response');
      return response['rows'];
    } catch (e) {
      return <dynamic>[];
    }
  }

  Future<List<T>?> getTableData() async {
    DatabaseHelper dbHelper = new DatabaseHelper();

    dbHelper.tableName = tableName;
    // dbHelper.list = columns;
    dbHelper.fields = columns;

    List<T> list = [];
    // List listFinal = await dbHelper.getTableData();
    final x = await dbHelper.getTableData();
    // x.map((e) => {print(e), list.add(unmarshal(e, type: T))});
    for (var item in x) {
      var x = unmarshal(item, type: T);
      list.add(x);
    }
    print(list);
    return list;
  }

  dynamic unmarshal<T>(json, {Type? type}) {
    type ??= T;

    switch (type) {
      case ItemModel:
        return ItemModel.fromJson(json);
      case Contact:
        return Contact.fromJson(json);
      default:
        throw StateError('Unable to unmarshal value of type \'$type\'');
    }
  }

  dynamic unmarshalTojson<T>(json, {Type? type}) {
    type ??= T;

    switch (type) {
      case ItemModel:
        return (json as ItemModel).toJson();
      default:
        throw StateError('Unable to unmarshal value of type \'$type\'');
    }
  }

  saveTodb(data) async {
    DatabaseHelper dbHelper = new DatabaseHelper();

    dbHelper.tableName = tableName;
    // dbHelper.list = columns;
    dbHelper.fields = columns;
    await dbHelper.dropTable();
    // await dbHelper.initDb();
    await dbHelper.saveTableData(data);
  }
}
