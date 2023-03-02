import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:new_tablet/models/contact_model.dart';
import 'package:new_tablet/models/item_model.dart';
import 'package:new_tablet/models/user_configs_model.dart';
import 'package:new_tablet/screens/contacts/contacts_screen.dart';
import 'package:new_tablet/screens/items/list_screen.dart';
import 'package:new_tablet/services/contacts_service.dart';
import 'package:new_tablet/services/database_service.dart';
import 'package:new_tablet/services/items_service.dart';
import 'package:new_tablet/utils/utils.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int contactsCount = 0;
  List<ItemModel>? itemsList;
  List<Contact>? contactsList;
  TextEditingController searchController = new TextEditingController();
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    utils.isDashboard = true;
    getData();
    super.initState();
  }

  void getData() async {
    // ItemsService().get(online: true).then((data) {
    //   setState(() {
    //     itemsList = data;
    //   });
    // });

    // ItemsService().getTableData().then((data) {
    //   setState(() {
    //     itemsList = data as List<ItemModel>;
    //   });
    // });

    ContactsService().getTableData().then((data) {
      setState(() {
        contactsList = data as List<Contact>;
      });
    });

    // ItemsService.getItems().then((data) {
    // setState(() {
    //   itemsList = data;
    // });
    // });
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        final bool connected = connectivity != ConnectivityResult.none;
        return Scaffold(
          appBar: AppBar(
            title: Text('managersApp'.tr),
            leading: Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Image.asset('assets/images/icon.png')),
            leadingWidth: 50,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomLeft,
                    colors: <Color>[
                      Color.fromARGB(255, 124, 5, 5),
                      Color.fromARGB(255, 226, 163, 163),
                    ]),
              ),
            ),
          ),
          body: new Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                height: 24.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  color: connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
                  child: Center(
                    child: Text("${connected ? 'ONLINE' : 'OFFLINE'}"),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // ElevatedButton(
                    //     onPressed: () => scanBarcodeNormal(),
                    //     child: Text('Start barcode scan')),
                    // ElevatedButton(
                    //     onPressed: () => scanQR(),
                    //     child: Text('Start QR scan')),
                    // ElevatedButton(
                    //     onPressed: () => startBarcodeScanStream(),
                    //     child: Text('Start barcode scan stream')),
                    // Text('Scan result : $_scanBarcode\n',
                    //     style: TextStyle(fontSize: 20)),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              settings: RouteSettings(name: '/contacts'),
                              builder: (context) =>
                                  // ListScreen(itemsList!, 'contacts'),
                                  ContactsScreen(contactsList!)),
                        );
                      },
                      child: Text('contacts'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            'There are no bottons to push :)',
          ),
          new Text(
            'Just turn off your internet.',
          ),
        ],
      ),
    );

    // Stack(
    //   children: <Widget>[
    //     Container(
    //       // Here the height of the container is 45% of our total height
    //       height: size.height * .4,
    //       decoration: BoxDecoration(
    //         gradient: LinearGradient(
    //           begin: Alignment.topRight,
    //           end: Alignment.bottomLeft,
    //           colors: [
    //             Color.fromARGB(255, 124, 5, 5),
    //             Color.fromARGB(255, 226, 163, 163),
    //           ],
    //         ),
    //       ),
    //     ),
    //     SafeArea(
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 20),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Align(
    //               alignment: AlignmentDirectional.topEnd,
    //               child: Container(
    //                 alignment: Alignment.center,
    //                 height: 52,
    //                 width: 52,
    //                 decoration: BoxDecoration(
    //                   color: kPrimaryColor,
    //                   shape: BoxShape.circle,
    //                 ),
    //                 child: IconButton(
    //                     icon: Icon(
    //                       Icons.notifications,
    //                       color: Colors.white,
    //                     ),
    //                     onPressed: () => Scaffold.of(context).openDrawer()),
    //               ),
    //             ),
    //             Text(
    //               "${'hello'.tr}! \n${utils.username.toUpperCase()}",
    //               style: TextStyle(
    //                   fontWeight: FontWeight.w900,
    //                   color: Colors.white,
    //                   fontSize: 20),
    //             ),
    //             SizedBox(
    //               height: 30,
    //             ),
    //             SearchWidget(searchController: searchController),
    //             SizedBox(
    //               height: 30,
    //             ),
    //             Container(
    //               child: GridView.count(
    //                 physics: ScrollPhysics(),
    //                 shrinkWrap: true,
    //                 crossAxisCount: 2,
    //                 childAspectRatio: .85,
    //                 crossAxisSpacing: 20,
    //                 mainAxisSpacing: 20,
    //                 children: <Widget>[
    //                   CategoryCard(
    //                     title: "contact".tr,
    //                     subTitle: contactsList != null
    //                         ? contactsList.length.toString()
    //                         : '',
    //                     svgSrc: "assets/images/undraw_connected.svg",
    //                     press: () {
    //                       List<Contact> copiedList = List.from(contactsList);
    //                       Navigator.push(
    //                         this.context,
    //                         MaterialPageRoute(
    //                           settings: RouteSettings(name: '/contacts'),
    //                           builder: (context) => ListScreen(
    //                               copiedList
    //                                 ..sort((a, b) => a.name.compareTo(b.name)),
    //                               'contacts'),
    //                         ),
    //                       );
    //                     },
    //                   ),
    //                   CategoryCard(
    //                     title: "stockBalance".tr,
    //                     subTitle: itemsList != null
    //                         ? itemsList.length.toString()
    //                         : '',
    //                     svgSrc: "assets/images/undraw_growth_curve.svg",
    //                     press: () {
    //                       Navigator.push(
    //                         context,
    //                         MaterialPageRoute(
    //                           settings: RouteSettings(name: '/items'),
    //                           builder: (context) =>
    //                               ListScreen(itemsList, 'items'),
    //                         ),
    //                       );
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             SizedBox(
    //               height: 10,
    //             ),
    //             currencyList != null
    //                 ? Container(
    //                     height: 100,
    //                     child: ListView.builder(
    //                       shrinkWrap: true,
    //                       scrollDirection: Axis.horizontal,
    //                       itemCount: currencyList.length,
    //                       itemBuilder: (BuildContext context, int i) =>
    //                           Container(
    //                         margin: const EdgeInsets.only(left: 3, right: 3),
    //                         padding: EdgeInsets.only(
    //                             left: 22, right: 22, top: 10, bottom: 10),
    //                         decoration: BoxDecoration(
    //                           color: Colors.white,
    //                           borderRadius: BorderRadius.circular(13),
    //                         ),
    //                         child: Column(
    //                           children: <Widget>[
    //                             Spacer(),
    //                             Text(
    //                               currencyList[i].symbol,
    //                               style: TextStyle(
    //                                   fontSize: 20,
    //                                   fontWeight: FontWeight.w900,
    //                                   color: kPrimaryColor),
    //                             ),
    //                             Spacer(),
    //                             Text(
    //                               currencyList[i].name,
    //                               textAlign: TextAlign.center,
    //                               style: TextStyle(fontSize: 15),
    //                             ),
    //                             SizedBox(
    //                               height: 5,
    //                             ),
    //                             Text(
    //                               num.parse(currencyList[i].rate)
    //                                   .toStringAsFixed(2),
    //                               textAlign: TextAlign.center,
    //                               style: TextStyle(fontWeight: FontWeight.w900),
    //                             )
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   )
    //                 : Container(),
    //           ],
    //         ),
    //       ),
    //     )
    //   ],
    // );
  }
}
