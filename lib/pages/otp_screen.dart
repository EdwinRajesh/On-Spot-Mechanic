import 'package:flutter/material.dart';

import 'package:pinput/pinput.dart';

import '../utilities/button.dart';

class OtpScreen extends StatefulWidget {
  //final String verificationId;
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
                Text(
                  'Verification',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Enter the OTP sent to your phone number',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Pinput(
                    length: 6,
                    showCursor: true,
                    keyboardType: TextInputType.number,
                    defaultPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.purple),
                      ),
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        otpCode = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 56),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: CustomButton(
                      text: 'Verify',
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//   void verifyOtp(BuildContext context, String otpCode, String verificationId) {
//     final ap = Provider.of<AuthProvider>(context, listen: false);
//     ap.verifyOtp(
//       context: context,
//       verificationId: verificationId,
//       otpCode: otpCode,
//       onSuccess: () {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProfileScreen(),
//           ),
//         );
//       },
//       onFailure: () {
//         // Handle failure
//       },
//     );
//   }
}
