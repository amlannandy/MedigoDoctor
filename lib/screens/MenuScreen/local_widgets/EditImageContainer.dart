import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../services/UserInfoProvider.dart';

Widget editImageContainer(BuildContext context, String imageUrl, Function callback) {
  return Container(
    alignment: Alignment.center,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                UserInfoProvider.currentImageUrl.isNotEmpty ? UserInfoProvider.currentImageUrl : imageUrl
              ),
              fit: BoxFit.cover,
            )
          ),
        ),
        Positioned(
          bottom: 0,
          right: 10,
          child: GestureDetector(
            onTap: callback,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                LineIcons.camera_retro,
                color: Colors.white.withOpacity(0.7),
                size: 25,
              ),
            ),
          ),
        )
      ],
    ),
  );
}