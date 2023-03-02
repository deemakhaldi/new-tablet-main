// import 'package:animations/models/contact_model.dart';
// import 'package:animations/screens/contacts/list_screen.dart';
// import 'package:animations/screens/contacts/widgets/item_list_tile.dart';
// import 'package:animations/screens/dashboard/dashboard_screen.dart';
// import 'package:animations/screens/home/home_screen.dart';
// import 'package:animations/screens/login/login_screen.dart';
// import 'package:flutter/material.dart';

// class RouteGenerator {
//   static String currentRoute;
//   static String oldRoute;

//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     final arguments = settings.arguments;
//     currentRoute = settings.name;
//     switch (settings.name) {
//       case '':
//         return MaterialPageRoute(
//           builder: (_) => LoginScreen(),
//         );
//       // case 'dashboard':
//       //   return MaterialPageRoute(
//       //     builder: (_) => DashboardScreen(),
//       //   );
//       case 'home':
//         return MaterialPageRoute(
//           builder: (_) => HomeScreen(),
//         );
//       // case 'contacts':
//       //   return MaterialPageRoute(
//       //     builder: (_) => ListPage(arguments),
//       //   );

//       case 'contact_details':
//         return MaterialPageRoute(
//           builder: (_) => ItemListTile(
//             item: arguments,
//           ),
//         );

//       default:
//         return MaterialPageRoute(builder: (_) => LoginScreen());
//     }
//   }

//   static Route<dynamic> generateChildrenRoutes(RouteSettings settings) {
//     final arguments = settings.arguments;
//     currentRoute = settings.name;
//     switch (settings.name) {
//       case '':
//         return MaterialPageRoute(
//           builder: (_) => HomeScreen(),
//         );
//       case 'home':
//         return MaterialPageRoute(
//           builder: (_) => HomeScreen(),
//         );
//       // case 'dashboard':
//       //   return MaterialPageRoute(
//       //     builder: (_) => DashboardScreen(),
//       //   );
//       // case 'contacts':
//       //   return MaterialPageRoute(
//       //     builder: (_) => ListPage(),
//       //   );
//       case 'contacts':
//         return MaterialPageRoute(
//           builder: (_) => ListScreen([], ''),
//         );

//       case 'contact_details':
//         return MaterialPageRoute(
//           builder: (_) => ItemListTile(
//             item: arguments,
//           ),
//         );

//       default:
//         return MaterialPageRoute(builder: (_) => LoginScreen());
//     }
//   }
// }

// class ErrorPage extends StatelessWidget {
//   const ErrorPage({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: const Center(child: Text('Error')),
//     );
//   }
// }
