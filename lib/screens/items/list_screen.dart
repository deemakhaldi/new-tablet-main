import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_tablet/locator.dart';
import 'package:new_tablet/models/item_model.dart';
import 'package:new_tablet/screens/items/widgets/item_list_tile.dart';
import 'package:new_tablet/services/api_service.dart';
import 'package:new_tablet/services/contacts_service.dart';
import 'package:new_tablet/services/items_service.dart';
import 'package:new_tablet/utils/constants.dart';
import 'package:new_tablet/utils/utils.dart';
import 'package:new_tablet/widgets/custom_widgets.dart';

class ListScreen extends StatefulWidget {
  final List<ItemModel> list;
  final String type;
  const ListScreen(this.list, this.type);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<ItemModel> listFiltered = [];
  Map<String, Color> listColorMap = new Map();
  TextEditingController searchController = new TextEditingController();
  bool listLoaded = false;
  List<ItemModel> list = [];
  List<ItemModel> selectedItems = [];
  List<ItemModel>? itemsList = [];

  @override
  void initState() {
    setState(() {
      utils.isDashboard = false;
    });

    searchController.addListener(() {
      filterlist();
    });

    getData();
    super.initState();
  }

  getData() {
    ItemsService().getTableData().then((data) {
      setState(() {
        itemsList = data as List<ItemModel>;
      });
    });
  }

  filterlist() {
    List<ItemModel> _list = [];
    _list.addAll(widget.list.isNotEmpty ? widget.list : itemsList!);
    if (searchController.text.isNotEmpty) {
      _list.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String contactName = contact.name!.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);

        if (nameMatches == true) {
          return true;
        }
        return false;
      });
    }
    setState(() {
      listFiltered = _list;
    });
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Center(
              child: Text(
                '${widget.type}'.tr.toUpperCase(),
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            SearchWidget(searchController: searchController),
            Flexible(
              child: Column(
                children: [
                  Flexible(
                      child: ListView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,

                    primary: false,
                    addAutomaticKeepAlives: false,
                    // itemExtent: 2000,
                    itemCount: (isSearching == true
                        ? listFiltered.length
                        : (widget.list.isNotEmpty
                            ? widget.list.length
                            : itemsList!.length)),
                    itemBuilder: (context, index) {
                      return ItemListTile(
                          item: (isSearching == true
                              ? listFiltered[index]
                              : widget.list.isNotEmpty
                                  ? widget.list[index]
                                  : itemsList![index]),
                          callback: (val) {
                            // print(widget.list.isNotEmpty ? widget.list : itemsList![index].quantity! > 0);
                            setState(() {
                              // widget.list.isNotEmpty ? widget.list : itemsList![index].quantity = val;

                              // if (widget.list.isNotEmpty ? widget.list : itemsList![index].quantity > 0 &&
                              //     selectedItems
                              //         .where((element) =>
                              //             element.code ==
                              //             widget.list.isNotEmpty ? widget.list : itemsList![index].code)
                              //         .isEmpty) {
                              //   selectedItems.add(widget.list.isNotEmpty ? widget.list : itemsList![index]);
                              // } else if (widget.list.isNotEmpty ? widget.list : itemsList![index].quantity == 0) {
                              //   selectedItems.removeWhere((item) =>
                              //       item.code == widget.list.isNotEmpty ? widget.list : itemsList![index].code);
                              // }
                            });
                          });
                    },
                  )
                      // child: ListView(
                      //   padding: EdgeInsets.symmetric(vertical: 8.0),
                      //   children: (isSearching == true
                      //           ? listFiltered
                      //           : widget.list.isNotEmpty ? widget.list : itemsList!)
                      //       .map(
                      //         (Item) => ItemListTile(
                      //             item: Item,
                      //             callback: (val) => setState(() {
                      //                   print(val);
                      //                   Item.quantity = val;

                      //                   if (Item.quantity > 0 &&
                      //                       selectedItems
                      //                           .where((element) =>
                      //                               element.code == Item.code)
                      //                           .isEmpty) {
                      //                     selectedItems.add(Item);
                      //                   } else {
                      //                     selectedItems.removeWhere(
                      //                         (item) => item.code == Item.code);
                      //                   }
                      //                 })),
                      //       )
                      //       .toList(),
                      // ),
                      ),
                  Container(
                    height: 70,
                    width: 120,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 238, 238, 238)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Color.fromARGB(
                                              255, 238, 238, 238))))),
                      child: ModalRoute.of(context)?.settings.name == '/order'
                          ? const Text(
                              "Send",
                              style: TextStyle(color: kPrimaryColor),
                            )
                          : const Text(
                              "Choose",
                              style: TextStyle(color: kPrimaryColor),
                            ),
                      onPressed: () async {
                        print(
                            'ModalRoute.of(context)?.settings.name ${ModalRoute.of(context)?.settings.name}');
                        if (ModalRoute.of(context)?.settings.name == '/order') {
                          print(ContactsService.selectedContact);
                          print(widget.list);
                          Map obj = {
                            "TRANSACTION_ID": "79451677507582140",
                            "stationId": "695141687132171",
                            "record": {
                              "contact": ContactsService.selectedContact,
                              "docDate": "02/27/2023",
                              "salesman": "009",
                              "currency": "01",
                              "totalNet": "0",
                              "docFormat": "Include Tax",
                              "discountPercent": "0",
                              "campaignDiscount": "0",
                              "earnedPoints": "0",
                              "discountTotal": "0",
                              "orderDetail": [],
// {
// "item":"000000105",
// "unit":"PCS",
// "quantity":"1",
// "bonus":"0",
// "price":"8.621",
// "discountPercent":"0",
// "pointsTotal":"0",
// "batch":[
// ],
// "serial":""
// }
// ],
                              "pos": "DK",
                              "posRounding": "1",
                              "branch": "01",
                              "project": "000000",
                              "department": "000"
                            }
                          };

                          widget.list.forEach((i) {
                            obj['record']['totalNet'] =
                                (double.parse(obj['record']['totalNet']) +
                                        (double.parse(i.defaultPrice!) *
                                            i.quantity!))
                                    .toString();
                            obj['record']['orderDetail'].add({
                              "item": i.code,
                              "unit": i.defaultUnit,
                              "quantity": i.quantity,
                              "bonus": "0",
                              "price": i.defaultPrice,
                              "discountPercent": "0",
                              "pointsTotal": "0",
                            });
                          });

                          var response = await locator
                              .get<ApiBaseHelper>()
                              .post('salesOrder', obj);

                              print('res $response');
                        } else {
                          selectedItems = (widget.list.isNotEmpty
                                  ? widget.list
                                  : itemsList!)
                              .where((i) => i.quantity! > 0)
                              .toList();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              settings: RouteSettings(name: '/order'),
                              builder: (context) =>
                                  ListScreen(selectedItems, 'items'),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
