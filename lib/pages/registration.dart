// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:on_spot_mechanic/pages/home.dart';

import 'package:on_spot_mechanic/providers/auth_service.dart';
//import 'package:on_spot_mechanic/pages/otp_screen.dart';

import '../utilities/button.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();

  bool isValidPhone = false;

  void updateValidity() {
    setState(() {
      isValidPhone =
          phoneController.text.length == 10 && isNumeric(phoneController.text);
    });
  }

  bool isNumeric(String text) {
    RegExp numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Registration',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Add your phone number. We\'ll send you an authentication code',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),
                textField(),
                SizedBox(height: 32),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: registerButton(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding textField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Form(
        key: _formKey,
        child: TextFormField(
          keyboardType: TextInputType.phone,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          controller: phoneController,
          cursorColor: Colors.purple,
          onChanged: (value) {
            updateValidity();
          },
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 11.0, 8.0, 0),
              child: Text(
                '+91',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 13, 10, 13)),
              ),
            ),
            suffixIcon: isValidPhone
                ? Icon(
                    Icons.check_circle,
                    color: Colors.purple,
                    size: 32,
                  )
                : null,
            hintText: "Enter phone number",
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.purple),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.purple),
            ),
          ),
        ),
      ),
    );
  }

  Padding registerButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomButton(
        text: 'Register',
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            AuthService.sentOtp(
                phoneNumber: phoneController.text,
                errorStep: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Erro in sending OTP")));
                },
                nextStep: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("OTP"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Form(
                                key: _formKey1,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: otpController,
                                ),
                              )
                            ],
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  if (_formKey1.currentState!.validate()) {
                                    AuthService.loginWithOtp(
                                            otp: otpController.text)
                                        .then((value) {
                                      if (value == 'Success') {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()));
                                      } else {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                                SnackBar(content: Text(value)));
                                      }
                                    });
                                  }
                                },
                                child: Text('Submit'))
                          ],
                        );
                      });
                });
          }
        },
      ),
    );
  }
}
