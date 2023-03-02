import 'package:get/get.dart';

class Contact {
  String? code;
  String? name;
  String? currentBalance;
  String? discountPercent;
  String? maxCredit;
  String? chkMaxCredit;
  String? area;
  String? phone;
  String? cusCurrency;
  String? cusAccount;
  String? mobile;
  String? email;
  String? cusPriceList;
  String? customerExpiry;
  String? taxId;
  String? cusTaxType;
  String? postdatedBalance;
  String? streetAddress;
  String? sectorName;
  String? typeName;
  bool? isCustomer;
  bool? isSupplier;
  bool? isEmployee;

  Contact({
    this.code,
    this.name,
    this.currentBalance,
    this.discountPercent,
    this.maxCredit,
    this.chkMaxCredit,
    this.area,
    this.phone,
    this.cusCurrency,
    this.cusAccount,
    this.mobile,
    this.email,
    this.cusPriceList,
    this.customerExpiry,
    this.taxId,
    this.cusTaxType,
    this.postdatedBalance,
    this.streetAddress,
    this.sectorName,
    this.typeName,
    this.isCustomer,
    this.isSupplier,
    this.isEmployee,
  });

  Contact.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    currentBalance = json['currentBalance'];
    discountPercent = json['discountPercent'];
    maxCredit = json['maxCredit'];
    chkMaxCredit = json['chkMaxCredit'];
    area = json['area'];
    phone = json['phone'];
    cusCurrency = json['cusCurrency'];
    cusAccount = json['cusAccount'];
    mobile = json['mobile'];
    email = json['email'];
    cusPriceList = json['cusPriceList'];
    customerExpiry = json['customerExpiry'];
    taxId = json['taxId'];
    cusTaxType = json['cusTaxType'];
    postdatedBalance = json['postdatedBalance'];
    streetAddress = json['streetAddress'];
    sectorName = json['sector.name'];
    typeName = json['type_name'];
    isCustomer = json['isCustomer'] == 'yes'.tr;
    isSupplier = json['isSupplier'] == 'yes'.tr;
    isEmployee = json['isEmployee'] == 'yes'.tr;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['currentBalance'] = this.currentBalance;
    data['discountPercent'] = this.discountPercent;
    data['maxCredit'] = this.maxCredit;
    data['chkMaxCredit'] = this.chkMaxCredit;
    data['area'] = this.area;
    data['phone'] = this.phone;
    data['cusCurrency'] = this.cusCurrency;
    data['cusAccount'] = this.cusAccount;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['cusPriceList'] = this.cusPriceList;
    data['customerExpiry'] = this.customerExpiry;
    data['taxId'] = this.taxId;
    data['cusTaxType'] = this.cusTaxType;
    data['postdatedBalance'] = this.postdatedBalance;
    data['streetAddress'] = this.streetAddress;
    data['sector.name'] = this.sectorName;
    data['type_name'] = this.typeName;
    data['isCustomer'] = this.isCustomer;
    data['isSupplier'] = this.isSupplier;
    data['isEmployee'] = this.isEmployee;
    return data;
  }
}
