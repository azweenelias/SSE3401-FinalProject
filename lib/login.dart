import 'package:flutter/material.dart';
import 'background.dart';
import 'main.dart';

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
                ? PhoneLogin(
                    changeState: changeState,
                  )
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
  final VoidCallback changeState;

  const PhoneLogin({Key? key, required this.changeState}) : super(key: key);

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  bool isChecked = false;

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
                      fontSize: 20, color: Colors.black.withOpacity(0.6)),
                )),
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
              const Expanded(
                child: TextField(
                  key: Key("phone1"),
                  decoration: InputDecoration(
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
                      setState(() {
                        widget.changeState();
                      });
                    }
                  : null,
              child: const Text(
                'Get Activation Code',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

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
                        fontSize: 20, color: Colors.black.withOpacity(0.6)),
                  )),
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
                Text('Didnt receive?', style: TextStyle(fontSize: 20)),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FactoryPage()));
                      }
                    : null,
                child: const Text(
                  'Activate',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ));
  }
}
