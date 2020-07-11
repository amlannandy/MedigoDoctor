import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/Doctor.dart';
import '../../../widgets/PrimaryButton.dart';
import '../../../widgets/LoadingSpinner.dart';
import '../../../services/UserInfoProvider.dart';
import '../local_widgets/EditImageContainer.dart';
import '../../../services/UserDatabaseService.dart';
import '../../HomeScreen/local_widgets/CustomAppBar.dart';
import '../../../screens/MenuScreen/local_widgets/EditField.dart';
import '../../RegistrationScreens/local_widgets/LightIconButton.dart';

class EditProfileScreen extends StatefulWidget {

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  FirebaseUser user;
  Doctor doctor;
  final UserDatabaseService userDatabaseService = UserDatabaseService();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _fieldController = TextEditingController();
  final _hospitalController = TextEditingController();
  final _cityController = TextEditingController();
  final _experienceController = TextEditingController();
  final _ageController = TextEditingController();

  void updateValues() async {
    user = await FirebaseAuth.instance.currentUser();
    doctor = await userDatabaseService.getDoctor(user.uid);
    setState(() {
      _nameController.text = doctor.name;
      _phoneController.text = doctor.phone;
      _emailController.text = doctor.email;
      _fieldController.text = doctor.field;
      _hospitalController.text = doctor.hospital;
      _cityController.text = doctor.city;
      _experienceController.text = doctor.experience.toString();
      _ageController.text = doctor.age.toString();
      UserInfoProvider.currentImageUrl = doctor.imageUrl;
    });
  }

  @override
  void initState() {
    updateValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Edit Profile'),
      backgroundColor: Colors.white,
      body: doctor == null ? loadingSpinner(context) : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            editImageContainer(
              context, 
              doctor.imageUrl, 
              () => showUploadDialog(context),
            ),
            editField(
              context: context,
              hinttext: 'Name',
              controller: _nameController,
              disabled: true,
            ),
            editField(
              context: context,
              hinttext: 'Phone Number',
              controller: _phoneController,
              disabled: true,
            ),
            editField(
              context: context,
              hinttext: 'Email Address',
              controller: _emailController,
              disabled: true,
            ),
            editField(
              context: context,
              hinttext: 'Age',
              controller: _ageController,
              disabled: false,
              keyboardtype: TextInputType.number,
            ),
            editField(
              context: context,
              hinttext: 'Medical Field',
              controller: _fieldController,
              disabled: true,
            ),
            editField(
              context: context,
              hinttext: 'Years of Experience',
              controller: _experienceController,
              disabled: false,
            ),
            editField(
              context: context,
              hinttext: 'Hospital',
              controller: _hospitalController,
              disabled: false,
            ),
            editField(
              context: context,
              hinttext: 'City',
              controller: _cityController,
              disabled: false,
            ),
            SizedBox(height: 20),
            PrimaryButton(
              text: 'UPDATE',
              press: () => UserInfoProvider.updateUserInfo(
                context: context,
                userId: user.uid,
                age: _ageController.text,
                hospital: _hospitalController.text,
                experience: _experienceController.text,
                location: _cityController.text,
              ),
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 20),
          ],
        ),
      )
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
        title: Text(
          "Upload Picture",
          style: TextStyle(
            fontFamily: 'Lato', 
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LightIconButton(
              icon: Icons.camera_alt,
              text: "Camera",
              function: () {
                UserInfoProvider.takePicture(context, () => {setState(() {})});
                Navigator.of(context).pop();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LightIconButton(
              icon: Icons.filter,
              text: "Gallery",
              function: () {
                UserInfoProvider.uploadPicture(context, () => {setState(() {})});
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      )
    );
  }
}