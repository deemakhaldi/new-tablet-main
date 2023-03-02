import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:new_tablet/models/contact_model.dart';
import 'package:new_tablet/screens/items/list_screen.dart';
import 'package:new_tablet/services/contacts_service.dart';

class ContactsScreen extends StatefulWidget {
  final List<Contact>? contactsList;
  const ContactsScreen(this.contactsList, {super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: widget.contactsList!.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final item = widget.contactsList![index];

          return ListTile(
            title: Text(item.name!),
            onTap: () {
              ContactsService.selectedContact = item.code;
              Navigator.push(
                context,
                MaterialPageRoute(
                  settings: RouteSettings(name: '/contacts'),
                  builder: (context) => ListScreen([], 'items'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
