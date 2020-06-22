import 'package:flutter/material.dart';

import '../../../models/MenuItem.dart';

class MenuItemWidget extends StatelessWidget {

  final MenuItem item;

  MenuItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => item.onPress(context),
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    item.icon,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 5),
                  Text(
                    item.title,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}