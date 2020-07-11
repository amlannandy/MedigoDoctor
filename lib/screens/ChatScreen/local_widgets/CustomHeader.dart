import 'package:flutter/material.dart';

Widget customHeader(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.8)),
      )
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'MediGo',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: Text(
                    'Pvt. Limited',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Email - medigoteambbsr@gmail.com\nPhone - 7205835571',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 14,
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Image.asset(
              'assets/images/qrcode.png',
              height: 70,
              width: 70,
            ),
            SizedBox(height: 5),
            Container(
              width: 70,
              child: Text(
                'Scan to use our services',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Widget customFooter(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(width: 1, color: Colors.black.withOpacity(0.8)),
      )
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'Issued by - ',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Dr. Amlan Nandy',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 12,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Image.asset(
          'assets/images/signature.png',
          height: 40,
        ),
      ],
    ),
  );
}