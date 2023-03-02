import 'package:new_tablet/services/api_service.dart';

const fields = [
  'contact',
  'stockBalance',
  'reports',
  'documents',
  'customerStatement',
  'salesByCustomer',
  'logOut',
  'about',
  'search',
  'price',
  'code',
  'name',
  'currentBalance',
  'phone',
  'mobile',
  'email',
  'yes',
  'no',
  'customer',
  'supplier',
  'employee',
  'salesOrder',
  'invoice',
  'salesReturn',
  'save',
  'filters',
  'from',
  'to',
  'shownCurr',
  'runningBalance',
  'account',
  'totalNet',
  'orderDetail',
  'docDate',
  'contactName',
  'currency',
  'salesman',
  'contactBalance',
  'discountPercent',
  'total',
  'quantity',
  'sales',
  'returns',
  'balance',
  'credit',
  'unit',
  'noResultsFound',
];

class LocalizationService {
  static getLocalizationStrings() async {
    try {
      return await APIService.getLocalizationStrings(fields);
    } catch (e) {
      return Future.error(e);
    }
  }
}
