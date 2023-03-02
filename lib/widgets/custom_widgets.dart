import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  String controller;
  final IconData icon;
  final String errorText;
  final bool isPassword;
  Function(String?) callback;

  CustomTextField(
    this.callback, {
    required this.hint,
    required this.controller,
    required this.icon,
    required this.errorText,
    required this.isPassword,
  });

  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: TextEditingController(text: widget.controller),
      keyboardType: TextInputType.name,
      onSaved: (value) => widget.callback(value),
      validator: (input) => input == '' ? widget.errorText : null,
      obscureText: widget.isPassword && hidePassword,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 238, 238, 238), width: 5.0),
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: widget.hint,
          // enabledBorder: UnderlineInputBorder(
          //     borderSide: BorderSide(
          //         color: Theme.of(context).accentColor.withOpacity(0.2))),
          // focusedBorder: UnderlineInputBorder(
          //     borderSide: BorderSide(color: Theme.of(context).accentColor)),
          prefixIcon: Icon(
            widget.icon,
            color: Color.fromARGB(255, 238, 238, 238),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility),
                )
              : null),
      style: TextStyle(color: Color.fromARGB(255, 238, 238, 238)),
    );
  }
}

class DatePicker extends StatefulWidget {
  final date;
  final label;
  const DatePicker({this.date, this.label});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          style: Theme.of(context).textTheme.bodyText2,
          controller: widget.date, //editing controller of this TextField
          decoration:
              InputDecoration(labelText: widget.label //label text of field
                  ),
          readOnly: true, //set it true, so that user will not able to edit text
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101));

            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('dd/MM/yyyy').format(pickedDate);
              setState(() {
                widget.date.text = formattedDate;
              });
            } else {
              print("Date is not selected");
            }
          },
        ),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  const SearchWidget({Key? key, required this.searchController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35.0),
        boxShadow: const [
          BoxShadow(offset: Offset(0, 2), blurRadius: 7, color: Colors.grey)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    hintText: "search".tr,
                    hintStyle:
                        TextStyle(color: const Color.fromARGB(255, 121, 0, 0)),
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
