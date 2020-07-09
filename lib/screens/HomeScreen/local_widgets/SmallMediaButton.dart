import 'package:flutter/material.dart';

Widget smallMediaButton({BuildContext context, IconData icon, String title, Function onPress}) {
  return GestureDetector(
    onTap: onPress,
    child: Container(
      width: 150,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Lato',
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
  );
}