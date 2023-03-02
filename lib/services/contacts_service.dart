import 'dart:convert';
import 'package:new_tablet/models/contact_model.dart';
import 'package:new_tablet/services/entity_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactsService extends EntityService<Contact> {
  @override
  List<String> columns = [
    'code',
    'name',
    'currentBalance',
    'discountPercent',
    'maxCredit',
    'chkMaxCredit',
    'area',
    'phone',
    'cusCurrency',
    'cusAccount',
    'mobile',
    'email',
    'cusPriceList',
    'customerExpiry',
    'taxId',
    'cusTaxType',
    'postdatedBalance',
    'streetAddress',
    // 'sector.name',
    // 'type.name',
    'isCustomer',
    'isSupplier',
    'isEmployee'
  ];

  @override
  String tableName = 'CONTACT';
  String apiComponent = 'CONTACT';

  static String? selectedContact;
  // Future<List<Contact>> getContacts() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   List<Contact> list = [];

  //   var response = await ApiBaseHelper().get('CONTACT', fields);
  //   for (var item in response['rows']) {
  //     Map<String, dynamic> map = item;
  //     list.add(Contact.fromJson(map));
  //   }
  //   await prefs.setString('contactsList', jsonEncode(list));
  //   return list;
  // }

  Future<List<dynamic>> getList<Contact>() async {
    var list = await super.getList();
    print('list $list');
    await super.saveTodb(list);
    // for (Map item in list) {
    //   print('%%%%%%%%%%% $item');
    // }

    return list;
  }
}
