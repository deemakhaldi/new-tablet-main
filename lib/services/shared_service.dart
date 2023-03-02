import 'package:new_tablet/services/api_service.dart';
import 'package:new_tablet/services/entity_service.dart';

class SharedService extends EntityService<dynamic> {
  @override
  List<String> columns = ['json'];
  @override
  String tableName = 'tablet_init';
  String apiComponent = 'tablet-init';
  Map configs = {};

  Future<List<dynamic>> getList() async {
    var list = await super.getList();
    await super.saveTodb(list);
    for (Map item in list) {
      print('%%%%%%%%%%% $item');
    }
    return list;
  }


    // static generateTransactionId() {
    //     // add transactionIdPrefix
    //     const time = new Date().getTime().toString();
    //     return '' + SharedData.configs.transactionIdPrefix + time;
    // }

}
