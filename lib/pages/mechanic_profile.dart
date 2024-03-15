import 'package:flutter/material.dart';

class MechanicProfile extends StatefulWidget {
  const MechanicProfile({Key? key}) : super(key: key);

  @override
  State<MechanicProfile> createState() => _MechanicProfileState();
}

class _MechanicProfileState extends State<MechanicProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mechanic Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text('Mechanic Profile Page'),
      ),
    );
  }
}
