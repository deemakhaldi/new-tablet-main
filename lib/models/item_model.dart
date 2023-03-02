import 'package:new_tablet/models/base_model.dart';

class ItemModel {
  String? code;
  String? name;
  String? defaultUnit;
  String? stockBalance;
  String? defaultPrice;
  double? quantity;
  String? itemAttachmentDetail_attachment_code;

  ItemModel(
      {this.code,
      this.name,
      this.defaultUnit,
      this.stockBalance,
      this.defaultPrice,
      this.quantity,
      this.itemAttachmentDetail_attachment_code});

  ItemModel.fromJson(dynamic json) {
    code = json['code'];
    name = json['name'];
    defaultUnit = json['defaultUnit'];
    stockBalance = json['stockBalance'];
    defaultPrice = json['defaultPrice'];
    quantity = 0;
    itemAttachmentDetail_attachment_code =
        json['itemAttachmentDetail_attachment_code'];
    // if (json['itemAttachmentDetail_attachment_code'] != null) {
    //   itemAttachmentDetail_attachment_code = <ItemAttachmentDetail>[];
    //   json['itemAttachmentDetail_attachment_code'].forEach((v) {
    //     itemAttachmentDetail_attachment_code
    //         ?.add(new ItemAttachmentDetail.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code!;
    data['name'] = this.name!;
    data['defaultUnit'] = this.defaultUnit!;
    data['stockBalance'] = this.stockBalance!;
    data['defaultPrice'] = this.defaultPrice!;
    data['quantity'] = '0';
    data['itemAttachmentDetail_attachment_code'] =
        this.itemAttachmentDetail_attachment_code!;
    //if (itemAttachmentDetail_attachment_code != null) {
    //  data['itemAttachmentDetail'] =
    //      itemAttachmentDetail_attachment_code?.map((v) => v.toJson()).toList();
    //}
    return data;
  }

  @override
  String toString() {
    return '{id: $code, title: $name}';
  }
}

class ItemAttachmentDetail {
  late String attachmentCode;
  late String itemCode;

  ItemAttachmentDetail({required this.attachmentCode, required this.itemCode});

  ItemAttachmentDetail.fromJson(Map<String, dynamic> json) {
    attachmentCode = json['attachment.code'];
    itemCode = json['itemCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attachment.code'] = this.attachmentCode;
    data['itemCode'] = this.itemCode;
    return data;
  }
}
