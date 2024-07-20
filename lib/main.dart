import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'login.dart';
import 'user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: LoginPage());
  }
}

class FactoryPage extends StatefulWidget {
  const FactoryPage({super.key});

  @override
  State<FactoryPage> createState() => _FactoryPageState();
}

class _FactoryPageState extends State<FactoryPage> {
  int currentIndex = 0;
  int currentFactoryIndex = 1;

  void changeFactoryIndex(int factoryNumber) {
    setState(() {
      currentFactoryIndex = factoryNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Factory $currentFactoryIndex'),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            iconSize: 30,
            onPressed: () {
              // Add your logic here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          color: Colors.grey[400],
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              currentIndex == 1
                  ? currentFactoryIndex == 1
                      ? const FactoryReader(
                          voltageSensor: 0,
                          readingSteamPressure: 0,
                          readingSteamFlow: 0,
                          readingWaterLevel: 0,
                          readingPowerFrequency: 0,
                          readingDateTime: '--:--',
                        )
                      : currentFactoryIndex == 2
                          ? const FactoryReader(
                              voltageSensor: 1549.7,
                              readingSteamPressure: 34.19,
                              readingSteamFlow: 22.82,
                              readingWaterLevel: 55.41,
                              readingPowerFrequency: 50.08,
                              readingDateTime: '2024-04-26 13:45:25')
                          : const FactoryReader(
                              voltageSensor: 0,
                              readingSteamPressure: 0,
                              readingSteamFlow: 0,
                              readingWaterLevel: 0,
                              readingPowerFrequency: 0,
                              readingDateTime: '--:--',
                            )
                  : currentIndex == 2
                      ? const ThresholdSection()
                      : currentIndex == 0
                          ? ContactSection(
                              currentFactoryIndex: currentFactoryIndex)
                          : ContactSection(
                              currentFactoryIndex: currentFactoryIndex),
              Container(
                height: MediaQuery.of(context).size.height * 0.22,
                padding: const EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FactoryButton(
                        key: const Key("factory1"),
                        factoryNumber: 1,
                        changeFactoryIndex: changeFactoryIndex,
                      ),
                      const SizedBox(width: 15),
                      FactoryButton(
                        key: const Key("factory2"),
                        factoryNumber: 2,
                        changeFactoryIndex: changeFactoryIndex,
                      ),
                      const SizedBox(width: 15),
                      FactoryButton(
                        key: const Key("factory3"),
                        factoryNumber: 3,
                        changeFactoryIndex: changeFactoryIndex,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined, key: Key("person_icon")),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.home, key: Key("home_icon")), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, key: Key("settings_icon")), label: ''),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

class FactoryButton extends StatelessWidget {
  const FactoryButton(
      {Key? key, required this.factoryNumber, required this.changeFactoryIndex})
      : super(key: key);

  final Function(int) changeFactoryIndex;
  final int factoryNumber;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.2,
      child: ElevatedButton(
        onPressed: () {
          changeFactoryIndex(factoryNumber);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.factory, size: 50),
            const SizedBox(height: 20),
            Text('Factory ${factoryNumber}',
                style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

class ContactSection extends StatefulWidget {
  final int currentFactoryIndex;

  const ContactSection({Key? key, required this.currentFactoryIndex})
      : super(key: key);

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  @override
  Widget build(BuildContext context) {
    List<User> usersForFactory =
        factoryContacts[widget.currentFactoryIndex] ?? [];

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.56,
      child: Stack(
        children: [
          Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[100],
              ),
              child: ListView.builder(
                itemCount: usersForFactory.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.blueGrey[100],
                    shadowColor: Colors.black,
                    child: ListTile(
                      leading: const Icon(Icons.circle,
                          size: 20, color: Colors.grey),
                      title: Text(usersForFactory[index].name),
                      subtitle: Text(usersForFactory[index].phone),
                    ),
                  );
                },
              )),
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton(
              backgroundColor: Colors.blueGrey[100],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InvitationPage(
                          currentFactoryIndex: widget.currentFactoryIndex)),
                );
              },
              child: const Icon(Icons.add, key: Key("add_button")),
            ),
          ),
        ],
      ),
    );
  }
}

class InvitationPage extends StatefulWidget {
  final int currentFactoryIndex;

  const InvitationPage({Key? key, required this.currentFactoryIndex})
      : super(key: key);

  @override
  State<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isSubmitEnabled = false;

  final String bearerToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjliNjFlOWJhZGViYzhkNDZkM2RhNmIiLCJpYXQiOjE3MjE0NTkyMTQsImV4cCI6MTcyMjA2NDAxNH0.jZ4Qs_jDXLSRtozS41rIvjLK2LTaDZBOSx4TKPH514k'; // Replace with your actual token

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      _checkSubmitButton();
    });
    phoneController.addListener(() {
      _checkSubmitButton();
    });
  }

  void _checkSubmitButton() {
    setState(() {
      isSubmitEnabled =
          nameController.text.isNotEmpty && phoneController.text.isNotEmpty;
    });
  }

  Future<void> addUser(String name, String phone) async {
    const String url =
        'http://10.114.16.240:5000/api/factories/:factoryId/engineers';
    final headers = {
      'Authorization': 'Bearer $bearerToken',
      'Content-Type': 'application/json'
    };
    final body = jsonEncode({
      "engineers": [
        {
          "name": name,
          "specialization": "Normal Engineer",
          "phoneNumber": phone,
        }
      ]
    });

    try {
      print('Sending request to $url with body: $body');
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final newUser = User(name: name, phone: phone);
        setState(() {
          if (factoryContacts.containsKey(widget.currentFactoryIndex)) {
            factoryContacts[widget.currentFactoryIndex]!.add(newUser);
          } else {
            factoryContacts[widget.currentFactoryIndex] = [newUser];
          }
        });
        Navigator.pop(context);
      } else {
        _showErrorDialog('Failed to add user: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      _showErrorDialog('Error adding user: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          iconSize: 30,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Factory ${widget.currentFactoryIndex}'),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          color: Colors.grey[400],
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text('Invitation',
                    style:
                        TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              ),
              const Center(
                child: Text('Invite user',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
              ),
              const SizedBox(height: 10),
              const Text('Owner\'s Name', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              TextField(
                key: const Key("name"),
                controller: nameController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: 'Type Here',
                ),
              ),
              const SizedBox(height: 20),
              const Text("Owner\'s Phone Number",
                  style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
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
                      key: const Key("phone2"),
                      controller: phoneController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        labelText: 'Enter your phone number',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: isSubmitEnabled
                      ? () {
                          addUser(nameController.text,
                              '+60${phoneController.text}');
                        }
                      : null,
                  child: const Text("Submit", style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FactoryReader extends StatefulWidget {
  final double voltageSensor;
  final double readingSteamPressure;
  final double readingSteamFlow;
  final double readingWaterLevel;
  final double readingPowerFrequency;
  final String readingDateTime;

  const FactoryReader({
    Key? key,
    required this.voltageSensor,
    required this.readingSteamPressure,
    required this.readingSteamFlow,
    required this.readingWaterLevel,
    required this.readingPowerFrequency,
    required this.readingDateTime,
  }) : super(key: key);

  @override
  State<FactoryReader> createState() => _FactoryReaderState();
}

class _FactoryReaderState extends State<FactoryReader> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[100],
        ),
        child: Column(
          children: [
            Text(
              widget.voltageSensor == 0
                  ? 'ABD1234 IS UNREACHABLE'
                  : '${widget.voltageSensor} kW',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildGaugeContainer(
                  title: 'Steam Pressure',
                  value: widget.readingSteamPressure,
                  unit: 'bar',
                ),
                _buildGaugeContainer(
                  title: 'Steam Flow',
                  value: widget.readingSteamFlow,
                  unit: 'T/H',
                ),
                _buildGaugeContainer(
                  title: 'Water Level',
                  value: widget.readingWaterLevel,
                  unit: '%',
                ),
                _buildGaugeContainer(
                  title: 'Power Frequency',
                  value: widget.readingPowerFrequency,
                  unit: 'Hz',
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              widget.readingDateTime,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGaugeContainer(
      {required String title, required double value, required String unit}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FittedBox(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                ),
              ),
            ),
            Container(
              height: 100,
              width: 100,
              padding: const EdgeInsets.all(10),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 100,
                        showLabels: false,
                        showTicks: true,
                        startAngle: 180,
                        endAngle: 0,
                        radiusFactor: 1.5,
                        canScaleToFit: true,
                        axisLineStyle: const AxisLineStyle(
                          thickness: 0.3,
                          thicknessUnit: GaugeSizeUnit.factor,
                        ),
                        pointers: <GaugePointer>[
                          RangePointer(
                            value: value,
                            color: value < 31 ? Colors.red : Colors.green,
                            width: 0.3,
                            sizeUnit: GaugeSizeUnit.factor,
                          ),
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                            widget: Text(
                              '$value $unit',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            angle: 90,
                            positionFactor: 0.4,
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThresholdSection extends StatelessWidget {
  const ThresholdSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.56,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[100],
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Expanded(
                    child: Text(
                  'Minimum Threshold',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
                const Icon(Icons.info_outline_rounded, size: 30),
                ElevatedButton(
                  onPressed: () {},
                  child: const Icon(Icons.edit),
                )
              ],
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _ThresholdText(title: 'Steam Pressure', value: 29, unit: 'bar'),
                _ThresholdText(title: 'Steam Flow', value: 22, unit: 'T/H'),
                _ThresholdText(title: 'Water Level', value: 53, unit: '%'),
                _ThresholdText(title: 'Power Frequency', value: 48, unit: 'Hz'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _ThresholdText({
    required String title,
    required int value,
    required String unit,
  }) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height: 100,
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  )),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '$value',
                      style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1)),
                  ),
                  Container(
                    width: 40,
                    child: Text(
                      '$unit',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
