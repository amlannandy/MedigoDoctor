import 'package:flutter/material.dart';

class FieldDropdownList extends StatefulWidget {

  final Function callback;

  const FieldDropdownList(this.callback);

  @override
  _FieldDropdownListState createState() => _FieldDropdownListState();
}

class _FieldDropdownListState extends State<FieldDropdownList> {

  List fields = ['General Medicine', 'Cardiology', 'Dermatology', 'Pediatrics', 'Pathology', 'Oncology', 'Radiology', 'Urology'];
  String selectedCrop = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: 360,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            children: <Widget>[
              customHeader(),
              Container(
                height: 300,
                child: ListView.builder(
                  itemBuilder: (ctx, index) => RadioListTile(
                    title: Text(fields[index].toString()),
                    groupValue: this.selectedCrop,
                    value: fields[index],
                    onChanged: (val) {
                      setState(() => selectedCrop = val);
                      widget.callback(val);
                    }
                  ),
                  itemCount: fields.length,
                )
              )
            ]
          )
        ),
      ),
    );
  }

  Widget customHeader() {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Select your Field',
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontFamily: 'Lato',
              fontSize: 18,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.cancel,
              color: Colors.black.withOpacity(0.8),
            ),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }
}