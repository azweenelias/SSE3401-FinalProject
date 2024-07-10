import 'package:flutter/material.dart';
import 'background.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int currentState = 1;

  void changeState() {
    setState(() {
      currentState = currentState == 1 ? 2 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "image/upmlogo.jpg",
              width: 170,
              height: 100,
              fit: BoxFit.contain,
            ),
            const Text(
              'Welcome!',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            currentState == 1
                ? PhoneLogin(changeState: changeState)
                : const OTPPage(),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Disclaimer | Privacy Statement',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Copyright UPM & Kejuruteraan Mingtak Sawit CSS Sdn.Bhd.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )),
    );
  }
}

class PhoneLogin extends StatefulWidget {
  final Function changeState;

  PhoneLogin({required this.changeState});

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  bool isChecked = false;
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: SizedBox(
                  child: Text(
                    'Enter your mobile number to activate your account.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
              Icon(
                Icons.info_outline_rounded,
                size: 30,
                color: Colors.black.withOpacity(0.6),
              )
            ],
          ),
          const SizedBox(height: 60),
          Row(
            children: [
              Image.asset(
                "image/malaysia.png",
                width: 30,
                height: 30,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 10),
              const Text("+60", style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: phoneController,
                  key: Key("phone1"),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                checkColor: Colors.white,
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              const Text('I agree to the terms and conditions',
                  style: TextStyle(fontSize: 15))
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: isChecked
                  ? () {
                      addUser();
                      // Call function to request OTP after user is registered
                      requestOTP(phoneController.text.trim());
                      widget.changeState();
                    }
                  : null,
              child: const Text(
                'Get Activation Code',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addUser() async {
    final String phoneNumber = phoneController.text.trim();
    if (phoneNumber.isEmpty) {
      print('Phone number is empty.');
      return;
    }

    final url = Uri.parse('http://10.104.0.248:5001/api/register');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'phone': phoneNumber});

    print('Sending request to $url with body: $body');

    try {
      final response = await http.post(url, headers: headers, body: body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('User added successfully');
        // After user is added successfully, request OTP
        requestOTP(phoneNumber);
        // Optionally, you can navigate to OTP verification screen here
      } else {
        print('Failed to add user: ${response.statusCode}');
        // Handle failure to add user
      }
    } catch (e) {
      print('Error adding user: $e');
      // Handle error
    }
  }

  // Function to request OTP from backend
  void requestOTP(String phoneNumber) async {
    final url = Uri.parse('http://10.104.0.248:5001/api/otp');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'phone': phoneNumber});

    print('Requesting OTP from $url with body: $body');

    try {
      final response = await http.post(url, headers: headers, body: body);
      print('OTP request status: ${response.statusCode}');
      print('OTP request body: ${response.body}');
      // Handle OTP request response here
    } catch (e) {
      print('Error requesting OTP: $e');
      // Handle error
    }
  }
}

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  TextEditingController otpController = TextEditingController();
  bool isFilled = false;

  void initState() {
    super.initState();
    otpController.addListener(() {
      _changeIsFilled();
    });
  }

  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  void _changeIsFilled() {
    setState(() {
      isFilled = otpController.text.length == 6;
    });
  }

  void activateUser(String otp) async {
    final url = Uri.parse(
        'http://10.104.0.248:5001/api/activate'); // Replace with your activation API URL
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'otp': otp}); // Send OTP in the request body

    print('Sending activation request to $url with body: $body');

    try {
      final response = await http.post(url, headers: headers, body: body);
      print('Activation response status: ${response.statusCode}');
      print('Activation response body: ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('User activated successfully');
        // Navigate to next screen or handle success
      } else {
        print('Failed to activate user: ${response.statusCode}');
        // Handle activation failure
      }
    } catch (e) {
      print('Error activating user: $e');
      // Handle activation error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  child: Text(
                    'Enter the activation code you received via SMS.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
              Icon(
                Icons.info_outline_rounded,
                size: 30,
                color: Colors.black.withOpacity(0.6),
              )
            ],
          ),
          const SizedBox(height: 50),
          TextField(
            key: const Key("otp"),
            maxLength: 6,
            controller: otpController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black.withOpacity(0.6)),
              ),
              hintText: 'OTP',
              hintStyle: TextStyle(
                fontSize: 20,
                color: Colors.black.withOpacity(0.6),
              ),
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Didn\'t receive?', style: TextStyle(fontSize: 20)),
              Text(
                'Tap here',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue,
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: isFilled
                  ? () {
                      // Assuming you have a function to validate OTP
                      if (otpController.text.trim() == '123456') {
                        activateUser(otpController.text.trim());
                        // Navigate to next screen or handle success
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FactoryPage()),
                        );
                      } else {
                        // Handle incorrect OTP
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Invalid OTP'),
                              content: const Text('Please enter a valid OTP.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  : null,
              child: const Text(
                'Activate',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
