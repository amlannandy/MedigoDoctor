import 'package:flutter/material.dart';

Widget iconButton(BuildContext context, { IconData icon, String text, Function onPress}) {
  return GestureDetector(
    onTap: onPress,
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 30,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontFamily: 'Varela',
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
  );
}