import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oru_phones/src/api/api.dart';
import 'package:oru_phones/src/view/home/home_screen.dart';
import 'package:oru_phones/src/view/auth/verify_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAccepted = false;
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _isLoading = false;
  String phNo = "0000000000";

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  void submit(int number) async {
    final ans = await Api.createOtp(number);
    if (ans) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyScreen(
            number: number,
          ),
        ),
      );
    } else {
      _showSnackbar("Invalid Number");
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              icon: Icon(Icons.close),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _header(),
                  SizedBox(height: 100),
                  _phn_num_area(),
                  SizedBox(height: 100),
                  _footer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        Image.asset("assets/logo.png"),
        SizedBox(height: 30),
        Text(
          "Welcome",
          style: TextStyle(
              fontSize: 36,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              color: Color(0xFF3F3E8F)),
        ),
        Text(
          "Sign in to continue",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
            color: Color(0xFF707070),
          ),
        ),
      ],
    );
  }

  Widget _phn_num_area() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter Your Phone Number",
            style: TextStyle(
              fontSize: 14,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
            ),
          ),
          TextField(
            onChanged: (no) {
              phNo = no;
            },
            controller: _phoneNumberController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "+91 ",
                      style: TextStyle(
                        color: Color(0xFF707070),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              hintText: "Mobile Number",
              hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                borderRadius: BorderRadius.circular(4),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _footer() {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: _isAccepted,
              onChanged: (bool? value) {
                setState(() {
                  _isAccepted = value ?? false;
                });
              },
            ),
            Text(
              'Accept',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 8),
            Text(
              "Terms and Conditions",
              style: TextStyle(
                color: Color(0xFF3E468F),
                fontSize: 16,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
        Center(
          child: MaterialButton(
            onPressed: _isAccepted && !_isLoading
                ? () {
                    submit(int.parse(phNo));
                  }
                : null,
            child: Container(
              decoration: BoxDecoration(
                color: _isAccepted ? Color(0xFF3F3E8F) : Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
              width: double.infinity,
              height: 50,
              child: Center(
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Next →',
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
        ),
      ],
    );
  }
}
