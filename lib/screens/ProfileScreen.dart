import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/MedigoUser.dart';
import '../widgets/CustomText.dart';
import '../services/UserInfoProvider.dart';
import '../services/UserDatabaseService.dart';

enum ProfileMode {
  View,
  Edit,
}

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  var _mode = ProfileMode.View;
  final UserDatabaseService userDatabaseService = UserDatabaseService();

  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: StreamBuilder<MedigoUser>(
        stream: userDatabaseService.streamUser(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingBanner();
          }
          if (!snapshot.hasData) {
            return Container();
          }
          final medigoUser = snapshot.data;
          return Container(
            color: Colors.white,
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(medigoUser.imageUrl),
                    radius: 60,
                  ),
                  SizedBox(height: 20),
                  editBanner(context, "Profile"),
                  Divider(color: Colors.grey[400], thickness: 0.4),
                  _mode == ProfileMode.View ? Column(
                    children: <Widget>[
                      infoPacket("Full Name", medigoUser.name),
                      infoPacket("City", medigoUser.city),
                      infoPacket("Age", medigoUser.age.toString()),
                    ],
                  ) : Column(
                    children: <Widget>[
                      editField(_nameController, medigoUser.name, false),
                      editField(_cityController, medigoUser.city, false),
                      editField(_ageController, medigoUser.age.toString(), true)
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  Widget editField(TextEditingController controller, String value, bool numeric) {
    controller.text = value;
    return TextField(
      controller: controller,
      keyboardType: numeric ? TextInputType.phone : TextInputType.text,
    );
  }

  Widget loadingBanner() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        valueColor: AlwaysStoppedAnimation(Colors.lightGreen),
      ),
    );
  }

  Widget infoPacket(String title, String value) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontFamily: 'varela',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'varela',
              fontSize: 18,
              color: Colors.grey
            ),
          ),
        ],
      ),
    );
  }

  Widget editBanner(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomText(
            text: title,
            size: 20,
            color: Colors.grey[700],
            isBold: true,
          ),
          InkWell(
            onTap: () {
              if (_mode == ProfileMode.View)
                setState(() => _mode = ProfileMode.Edit);
              else {
                setState(() => _mode = ProfileMode.View);
                UserInfoProvider.updateUserInfo(
                  name: _nameController.text,
                  age: _ageController.text,
                  location: _cityController.text,
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 5,
                bottom: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              child: Text(
                _mode == ProfileMode.View ? "Edit" : "Save",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 14,
                  fontFamily: 'Varela',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}