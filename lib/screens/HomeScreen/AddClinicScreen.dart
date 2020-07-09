import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:line_icons/line_icons.dart';

import './local_widgets/SmallMediaButton.dart';
import '../../services/UserInfoProvider.dart';
import './local_widgets/LocationInput.dart';
import '../../widgets/CustomTextField.dart';
import '../../widgets/PrimaryButton.dart';
import './local_widgets/CustomAppBar.dart';

class AddClinicScreen extends StatefulWidget {

  @override
  _AddClinicScreenState createState() => _AddClinicScreenState();
}

class _AddClinicScreenState extends State<AddClinicScreen> {

  Position _currentPosition;
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  void selectLocation(double lat, double long) {
    _currentPosition = Position(latitude: lat, longitude: long);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Add your Clinic'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              pictureContainer(context),
              CustomTextField(
                controller: _nameController, 
                icon: LineIcons.hospital_o, 
                labelText: 'Name of your Clinic'
              ),
              CustomTextField(
                controller: _phoneController,
                icon: LineIcons.phone,
                labelText: 'Contact Number',
                numeric: true,
              ),
              CustomTextField(
                controller: _addressController, 
                icon: LineIcons.home, 
                labelText: 'Address'
              ),
              LocationInput(selectLocation),
              PrimaryButton(
                text: 'SUBMIT',
                press: () => UserInfoProvider.uploadClinicData(
                  context: context,
                  name: _nameController.text,
                  phone: _phoneController.text,
                  address: _addressController.text,
                  location: _currentPosition,
                ),
                color: Theme.of(context).primaryColor
              ),    
            ],
          ),
        ),
      ),
    );
  }

  showUploadDialog(BuildContext context) {
    showDialog(
      context: context,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        titlePadding: const EdgeInsets.all(20),
        content: Container(
          alignment: Alignment.center,
          height: 160,
          child: Column(
            children: <Widget>[
              Text(
                "Upload Picture",
                style: TextStyle(
                  fontFamily: 'Lato', 
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: smallMediaButton(
                  context: context,
                  icon: Icons.camera_alt,
                  title: "Camera",
                  onPress: () {
                    UserInfoProvider.takePicture(context, () => {setState(() {})}, isClinic: true);
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: smallMediaButton(
                  context: context,
                  icon: Icons.filter,
                  title: "Gallery",
                  onPress: () {
                    UserInfoProvider.uploadPicture(context, () => {setState(() {})}, isClinic: true);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget pictureContainer(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 60,
            backgroundColor: Theme.of(context).accentColor.withOpacity(0.4),
            child: UserInfoProvider.clinicImageUrl.isEmpty ? Icon(
              LineIcons.hospital_o, 
              size: 70,
              color: Theme.of(context).primaryColor,
            ) : Container(),
            backgroundImage: UserInfoProvider.clinicImageUrl.isEmpty ? null : NetworkImage(UserInfoProvider.clinicImageUrl),
          ),
          SizedBox(height: 10),
          smallMediaButton(
            context: context,
            onPress: () => showUploadDialog(context),
            title: 'Upload Picture',
            icon: LineIcons.upload,
          ),
        ],
      ),
    );
  }
}