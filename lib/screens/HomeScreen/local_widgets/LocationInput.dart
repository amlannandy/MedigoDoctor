import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../local_widgets/MapScreen.dart';
import '../local_widgets/SmallMediaButton.dart';

class LocationInput extends StatefulWidget {

  final Function selectPlace;

  LocationInput(this.selectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {

  bool gotLocation = false;

  Future<void> _getCurrentUserLocation() async {
    final myLocation = await Geolocator().getCurrentPosition();
    setState(() {
      gotLocation = true;
    });
    widget.selectPlace(myLocation.latitude, myLocation.longitude);
  }

  Future<void> _selectOnMap() async {
    final Position selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => MapScreen()),
    );
    if (selectedLocation == null) {
      return;
    }
    setState(() {
      gotLocation = false;
    });
    widget.selectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
      ),
      height: 150,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 97,
            width: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(0.4),
            ),
            child: Text(
              gotLocation ? 'Location selected' : 'Location not selected',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'Varela',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              smallMediaButton(
                icon: Icons.my_location,
                title: 'My Location',
                onPress: _getCurrentUserLocation,
                context: context,
              ),
              SizedBox(height: 10),
              smallMediaButton(
                icon: Icons.location_city,
                title: 'Select on Map',
                onPress: _selectOnMap,
                context: context,
              ),
            ],
          )
        ],
      ),
    );
  }
}