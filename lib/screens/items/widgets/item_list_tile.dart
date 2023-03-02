import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:new_tablet/main.dart';
import 'package:new_tablet/models/item_model.dart';
import 'package:new_tablet/screens/items/widgets/image_carousel.dart';
import 'package:new_tablet/services/items_service.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:path/path.dart' as p;

typedef void StringCallback(double val);

class ItemListTile extends StatefulWidget {
  dynamic item;
  final StringCallback? callback;

  ItemListTile({@required this.item, this.callback});

  @override
  State<ItemListTile> createState() => _ItemListTileState();
}

class _ItemListTileState extends State<ItemListTile>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // if (widget.item.runtimeType == Contact) {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => ContactDetails(this.widget.item),
        //     ),
        //   );
        // }
      },
      child: ListTile(
        tileColor: widget.item.quantity > 0 ? Colors.yellow : null,
        contentPadding: EdgeInsets.all(3),
        leading: GestureDetector(
          onTap: () async {
            widget.item.runtimeType == ItemModel &&
                    widget.item.itemAttachmentDetail != null
                ? await showDialog(
                    context: context,
                    builder: (_) =>
                        ImageDialog(widget.item.itemAttachmentDetail),
                  )
                : null;
          },
          child: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            maxRadius: 20,
            child: widget.item.itemAttachmentDetail_attachment_code != null
                ? ClipOval(
                    child: Image(
                      image: NetworkToFileImage(
                        url: ItemsService.getImage(widget
                            .item.itemAttachmentDetail_attachment_code
                            ?.split(',')[0]),
                        file: fileFromDocsDir(
                            "${widget.item.itemAttachmentDetail_attachment_code?.split(',')[0]}.png"),
                        debug: true,
                      ),
                      errorBuilder: (context, error, stackTrace) {
                        return Text('Download image failed.');
                      },
                    ),

                    // Image.network(
                    //   ItemsService.getImage(widget.item.itemAttachmentDetail[0]
                    //       .toJson()['attachment.code']),
                    //   // errorBuilder: (BuildContext context, Object exception,
                    //   //     StackTrace stackTrace) {
                    //   //   return Text('error');
                    //   // },
                    //   fit: BoxFit.cover,
                    //   width: 50.0,
                    //   height: 50.0,
                    // ),
                  )
                : Text(
                    widget.item.name[0],
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ),
        title: Text(widget.item.name),
        subtitle: widget.item.runtimeType == ItemModel
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'stockBalance'.tr + ': ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: widget.item.stockBalance ?? '')
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'price'.tr + ': ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: widget.item.defaultPrice ?? '')
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'unit'.tr + ': ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: widget.item.defaultUnit ?? '')
                      ],
                    ),
                  ),
                ],
              )
            : null,
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        trailing: Container(
          width: 200,
          child: CupertinoSpinBox(
            min: 1,
            max: 9999,
            value: widget.item.quantity,
            onChanged: (value) {
              print('changed0');
              widget.item.quantity = value;
              widget.callback!(widget.item.quantity);
            },
          ),
        ),
        // trailing: new Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: <Widget>[
        //     widget.item.quantity != 0
        //         ? new IconButton(
        //             icon: new Icon(Icons.remove),
        //             onPressed: () => setState(() {
        //               widget.item.quantity--;
        //               widget.callback(widget.item.quantity);
        //             }),
        //           )
        //         : new Container(),
        //     new Text(widget.item.quantity.toString()),
        //     new IconButton(
        //         icon: new Icon(Icons.add),
        //         onPressed: () => setState(() {
        //               widget.item.quantity++;
        //               widget.callback(widget.item.quantity);
        //             }))
        //   ],
        // ),
      ),
    );
  }

  File fileFromDocsDir(String filename) {
    String pathName = p.join(appDocsDir.path, filename);
    return File(pathName);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
