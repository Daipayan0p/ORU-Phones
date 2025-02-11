import 'package:flutter/material.dart';
import 'package:oru_phones/src/app/app.locator.dart';
import 'package:oru_phones/src/service/auth_service.dart';
import 'package:oru_phones/src/view/home/home_screen.dart';
import 'package:oru_phones/src/view_model/auth_view_model.dart';
import 'package:stacked/stacked.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _isSubmitting = false;

  void submitName(AuthViewModel viewModel) async {
    String name = _nameController.text.trim();
    if (name.isEmpty) {
      _showSnackbar("Please enter your name.");
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isSubmitting = false;
    });
    print("Name submitted: $name");


    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
    viewModel.authenticate();
    print(viewModel.isAuthenticated);
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ViewModelBuilder.reactive(
        viewModelBuilder: () => AuthViewModel(locator<AuthService>()),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.white,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    }
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    _header(),
                    SizedBox(height: 60),
                    _nameField(),
                    SizedBox(height: 100),
                    _button(width, viewModel),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _button(double width, AuthViewModel viewModel) {
    return Center(
      child: MaterialButton(
        onPressed: _isSubmitting
            ? null
            : () {
                submitName(viewModel);
              },
        child: Container(
          decoration: BoxDecoration(
            color: _isSubmitting ? Colors.grey : Color(0xFF3F3E8F),
            borderRadius: BorderRadius.circular(4),
          ),
          width: width * 0.93,
          height: 50,
          child: Center(
            child: _isSubmitting
                ? CircularProgressIndicator(color: Colors.white)
                : Text(
                    'Confirm Name →',
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
            color: Color(0xFF3F3E8F),
          ),
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

  Widget _nameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Please Tell Us Your Name*",
            style: TextStyle(
              fontSize: 14,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
            ),
          ),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: "Name",
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
}
