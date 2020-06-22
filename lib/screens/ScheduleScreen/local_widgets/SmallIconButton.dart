import 'package:flutter/material.dart';

Widget smallIconButton(BuildContext context, { IconData icon, String text, Function onPress, Color color }) {
  return GestureDetector(
    onTap: onPress,
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: color == null ? Theme.of(context).accentColor.withOpacity(0.6) : color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              color: Theme.of(context).primaryColor.withOpacity(0.8),
              fontFamily: 'Varela',
              fontSize: 16,
            ),
          ),
          SizedBox(width: 10,),
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    ),
  );
}