import 'package:flutter/material.dart';

Widget editField({ @required BuildContext context, @required String hinttext, TextInputType keyboardtype = TextInputType.text, bool disabled=false, @required TextEditingController controller, int maxLength, double letterSpacing, bool validation = true, Key key, bool capitalize=false}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
    child: Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(10, 1, 1, 1),
          child: Text(
            hinttext,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontFamily: 'Varela',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextFormField(
          enabled: !disabled,
          controller: controller,
          keyboardType: keyboardtype,
          maxLength: maxLength,
          textCapitalization: capitalize ? TextCapitalization.characters : TextCapitalization.none ,
          style: TextStyle(letterSpacing: letterSpacing, fontSize: 16),
          decoration: InputDecoration(
            counterStyle: TextStyle(
              height: double.minPositive,
            ),
            counterText: "",
            hintText: hinttext,
            fillColor: Theme.of(context).accentColor.withOpacity(0.2),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
          ),
          validator: (value) {
            if (validation) {
              if (value.length == 0) {
                return 'Please enter your $hinttext';
              } 
            }
            return '';
          }
        ),
      ],
    ),
  );
}

