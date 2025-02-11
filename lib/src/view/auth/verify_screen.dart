import 'dart:async'; // Add this import for Timer
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oru_phones/src/api/api.dart';
import 'package:oru_phones/src/view/home/home_screen.dart';
import 'package:oru_phones/src/view/auth/name_screen.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key, required this.number});

  final int number;

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final List<TextEditingController> otpControllers =
      List.generate(4, (index) => TextEditingController());
  bool isResendEnabled = false;
  int resendTimer = 23;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startResendTimer();
  }

  void startResendTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        if (resendTimer > 0) {
          setState(() {
            resendTimer--;
          });
        } else {
          setState(() {
            isResendEnabled = true;
          });
          timer.cancel();
        }
      }
    });
  }

  void verifyOTP() async{
    String otpCode = otpControllers.map((c) => c.text).join();
    if (otpCode.length == 4) {
      if (await Api.validateOtp(widget.number, int.parse(otpCode))){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NameScreen()),
        );
      }else{
        _showSnackbar("Invalid OTP");
      }
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
  void resendOTP() {
    if (!isResendEnabled) return;
    setState(() {
      resendTimer = 23;
      isResendEnabled = false;
    });
    startResendTimer();
    print("Resending OTP...");
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _header(),
            SizedBox(height: 60),
            _otpView(),
            SizedBox(height: 60),
            _timerSection(),
            SizedBox(height: 100),
            _button(width)
          ],
        ),
      ),
    );
  }

  Widget _button(double width) {
    return Center(
      child: MaterialButton(
        onPressed: verifyOTP,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF3F3E8F),
            borderRadius: BorderRadius.circular(4),
          ),
          width: width * 0.8,
          height: 50,
          child: Center(
            child: Text(
              'Verify OTP',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 27,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _timerSection() {
    return Column(
      children: [
        Text(
          "Didn't receive OTP?",
          style: TextStyle(
            color: Color(0xFF757474),
            fontSize: 16,
          ),
        ),
        GestureDetector(
          onTap: resendOTP,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isResendEnabled
                    ? "Resend OTP"
                    : "Resend OTP in 0:$resendTimer Sec",
                style: TextStyle(
                  fontSize: 18,
                  color: isResendEnabled ? Colors.black87 : Colors.grey,
                  decoration: isResendEnabled ? TextDecoration.underline : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _otpView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: OtpField(controller: otpControllers[index]),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/logo.png"),
        SizedBox(height: 30),
        Text(
          "Verify Mobile No.",
          style: TextStyle(
            fontSize: 36,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            color: Color(0xFF3F3E8F),
          ),
        ),
        SizedBox(
          width: 350,
          child: Text(
            "Please enter the 4-digit verification code sent to your mobile number +91-${widget.number} via SMS",
            style: TextStyle(
              fontSize: 14,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400,
              color: Color(0xFF707070),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class OtpField extends StatelessWidget {
  final TextEditingController controller;

  const OtpField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 64,
      child: TextField(
        controller: controller,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: Theme.of(context).textTheme.headlineLarge,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFCCCCCC)),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFCCCCCC)),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
