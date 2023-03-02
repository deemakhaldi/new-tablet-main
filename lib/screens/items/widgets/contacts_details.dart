// import 'package:animations/models/contact_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ContactDetails extends StatelessWidget {
//   final Contact item;

//   ContactDetails(this.item);

//   @override
//   Widget build(BuildContext context) {
//     final detailKeys = [
//       'code',
//       'name',
//       'currentBalance',
//       'phone',
//       'mobile',
//       'email',
//     ];

//     Size screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Container(
//             height: screenSize.height / 4.7,
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//             ),
//           ),
//           SafeArea(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   SizedBox(height: screenSize.height / 8),
//                   Center(
//                     child: CircleAvatar(
//                       backgroundColor: Theme.of(context).primaryColor,
//                       child: Text(
//                         item.name[0],
//                         style: TextStyle(color: Colors.white, fontSize: 50),
//                       ),
//                       maxRadius: 65,
//                     ),
//                   ),
//                   Text(
//                     item.name,
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   Text(
//                     item.isCustomer
//                         ? 'customer'.tr
//                         : (item.isSupplier
//                             ? 'supplier'.tr
//                             : (item.isEmployee ? 'employee'.tr : '')),
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.w300,
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   for (var key in detailKeys)
//                     item.toJson()[key] != null
//                         ? Column(
//                             children: [
//                               Text.rich(
//                                 TextSpan(
//                                   children: [
//                                     TextSpan(
//                                         text: '${key.tr}: ',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold)),
//                                     TextSpan(text: item.toJson()[key])
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                             ],
//                           )
//                         : Container(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
