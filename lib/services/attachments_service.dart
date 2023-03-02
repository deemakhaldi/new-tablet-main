// ignore_for_file: overridden_fields

import 'package:new_tablet/models/item_model.dart';
import 'package:new_tablet/services/api_service.dart';
import 'package:new_tablet/services/entity_service.dart';
import 'package:new_tablet/utils/utils.dart';

class ItemsService extends EntityService<ItemModel> {
  @override
  List<String> columns = [
    'code',
    'itemCode',
  ];

  // List<Map<String, dynamic>> columns = [
  //   {
  //     'name': 'code',
  //     'type': 'TEXT',
  //     'allowNull': false,
  //     'isPrimary': true,
  //     'isUnique': true,
  //   },
  //   {
  //     'name': 'name',
  //     'type': 'TEXT',
  //     'allowNull': false,
  //   },
  //   {
  //     'name': 'defaultUnit',
  //     'type': 'TEXT',
  //     'allowNull': false,
  //   },
  //   {
  //     'name': 'stockBalance',
  //     'type': 'TEXT',
  //     'allowNull': false,
  //   },
  //   {
  //     'name': 'defaultPrice',
  //     'type': 'TEXT',
  //     'allowNull': false,
  //   },
  //   {
  //     'name': 'itemAttachmentDetail.attachment.code',
  //     'type': 'TEXT',
  //     'allowNull': false,
  //   }
  // ];

  @override
  String tableName = 'ATTACHMENTS';

  // static Future<List<ItemModel>> getItems() async {
  //   List<ItemModel> list = [];

  //   var response = await ApiBaseHelper().get('ITEM', fields);
  //   for (var item in response['rows']) {
  //     Map<String, dynamic> map = item;
  //     list.add(ItemModel.fromJson(map));
  //   }
  //   return list;
  // }

  static getImage(code) {
    return 'https://gw.bisan.com/api/v2/${utils.account}/attachment/${code}?bsn-token=${utils.token}';
  }

  saveTodb(data) {
    return super.saveTodb(data);
  }
}
