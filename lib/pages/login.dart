import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:on_spot_mechanic/pages/registration.dart';
import 'package:on_spot_mechanic/utilities/button.dart';
import 'welcome.dart'; // Import your welcome page here

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isValidPhone = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();

  bool isNumeric(String text) {
    RegExp numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(text);
  }

  void updateValidity() {
    setState(() {
      isValidPhone =
          phoneController.text.length == 10 && isNumeric(phoneController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WelcomePage()));
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Login to your account to access our services',
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
                  child: loginButton(context),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Not registered yet?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registration()),
                          );
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
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
                  color: const Color.fromARGB(255, 13, 10, 13),
                ),
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

  Padding loginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomButton(
        text: 'Sign In',
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            String phoneNumber = "+91${phoneController.text.trim()}";

            try {
              // Request verification code
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: phoneNumber,
                verificationCompleted: (PhoneAuthCredential credential) async {
                  await FirebaseAuth.instance.signInWithCredential(credential);
                  Navigator.pushReplacementNamed(context, '/home');
                },
                verificationFailed: (FirebaseAuthException e) {
                  // Handle verification failure
                  print(e.message);
                },
                codeSent: (String verificationId, int? resendToken) {
                  // Navigate to OTP verification screen passing verificationId
                  Navigator.pushNamed(
                    context,
                    '/otp_verification',
                    arguments: {'verificationId': verificationId},
                  );
                },
                codeAutoRetrievalTimeout: (String verificationId) {
                  // Handle code auto retrieval timeout
                  print('Timeout');
                },
                timeout: Duration(seconds: 60),
              );
            } catch (e) {
              // Handle exceptions
              print(e.toString());
            }
          }
        },
      ),
    );
  }
}
