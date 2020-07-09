import 'package:flutter/material.dart';
import 'package:medigo_doctor/services/UserInfoProvider.dart';

class FieldDropdownField extends StatefulWidget {

  final Function callback;
  final TextEditingController controller;

  FieldDropdownField(this.callback, this.controller);

  @override
  _FieldDropdownFieldState createState() => _FieldDropdownFieldState();
}

class _FieldDropdownFieldState extends State<FieldDropdownField> {

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        controller: widget.controller,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          UserInfoProvider.showFieldDropdown(context, widget.callback);
        },
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          hintText: 'Your Field of Practice',
          icon: Icon(
            Icons.filter_1,
            color: Theme.of(context).primaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}