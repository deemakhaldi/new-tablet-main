import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:get/get.dart';
import 'package:new_tablet/screens/catalog/catalog_list_screen.dart';
import 'package:new_tablet/screens/dashboard/dashboard_screen.dart';
import 'package:new_tablet/screens/dashboard/widgets/notifications_sidebar.dart';
import 'package:new_tablet/utils/utils.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Widget? _child;
  PersistentTabController? _controller;
  PageController _pageController = new PageController();
  var selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _child = DashboardScreen();
  }

  @override
  Widget build(BuildContext context) {
    _controller = PersistentTabController(initialIndex: 0);

    var myMenuItems = <String>[
      'about',
      'logOut',
    ];

    timeDilation = 1.5;
    return

        // GetMaterialApp(
        //   // initialRoute: 'home',
        //   // onGenerateRoute: RouteGenerator.generateChildrenRoutes,
        //   locale: Locale('ar'),
        //   translationsKeys: Get.find<TextTranslations>().keys,
        //   translations: Get.find<TextTranslations>(),
        //   title: 'Managers Appa',
        //   debugShowCheckedModeBanner: false,
        //   theme: ThemeData(
        //     colorScheme: ColorScheme.fromSwatch(
        //       primarySwatch: kPrimaryColor,
        //     ),
        //     brightness: Brightness.light,
        //     errorColor: Colors.white,
        //     textTheme: TextTheme(
        //       bodyText2: TextStyle(color: Colors.black),
        //     ),
        //     primaryColor: const Color.fromARGB(255, 121, 0, 0),
        //     accentColor: const Color.fromARGB(255, 192, 22, 28),
        //     fontFamily: 'Roboto',
        //   ),
        //   home:

        Scaffold(
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: NotificationsSidebar(),
      ),
      appBar: selectedIndex != 0 || (selectedIndex == 0 && !utils.isDashboard)
          ? AppBar(
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
              // actions: <Widget>[
              //   PopupMenuButton<String>(
              //       onSelected: onSelect,
              //       itemBuilder: (BuildContext context) {
              //         return myMenuItems.map((String choice) {
              //           return PopupMenuItem<String>(
              //             child: Text(choice.tr),
              //             value: choice,
              //           );
              //         }).toList();
              //       })
              // ],
            )
          : null,
      backgroundColor: Colors.grey[200],
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(context),
        onItemSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        confineInSafeArea: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style15,
      ),
      // ),
    );
  }
}

List<Widget> _buildScreens() {
  return [
    DashboardScreen(),
    DashboardScreen(),
    DashboardScreen(),
    DashboardScreen(),
    DashboardScreen(),

    // CatalogListScreen(),
    // CatalogListScreen(),
    // CatalogListScreen(),
    // CatalogListScreen(),

    // DashboardScreen(),
    // ReportsScreen(),
    // DashboardScreen(),
    // ProfileScreen(),
    // MoreScreen()
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems(context) {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.home),
      title: ("home".tr),
      activeColorPrimary: Theme.of(context).primaryColor,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.collections),
      title: ("reports".tr),
      activeColorPrimary: Theme.of(context).primaryColor,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Image.asset('assets/images/icon.png', height: 30, width: 30),
      title: ('    '),
      activeColorPrimary: Theme.of(context).primaryColor,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.person_crop_circle),
      title: ("profile".tr),
      activeColorPrimary: Theme.of(context).primaryColor,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.ellipsis),
      title: ("more".tr),
      activeColorPrimary: Theme.of(context).primaryColor,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}
