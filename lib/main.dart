import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
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
                      ? const FactoryReader()
                      : currentFactoryIndex == 2
                          ? const FactoryReader()
                          : const FactoryReader()
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
                itemCount: users.length,
                //
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.blueGrey[100],
                    shadowColor: Colors.black,
                    child: ListTile(
                      leading: const Icon(Icons.circle,
                          size: 20, color: Colors.grey),
                      title: Text(users[index].name),
                      subtitle: Text(users[index].phone),
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

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
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

  void addUser(String name, String phone) {
    users.add(User(name: name, phone: phone));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          iconSize: 30,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Factory ${widget.currentFactoryIndex}',
        ),
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
                      style: TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold))),
              const Center(
                  child: Text('Invite user',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.normal))),
              const SizedBox(height: 10),
              const Text(
                'Owner\'s Name',
                style: TextStyle(fontSize: 20),
              ),
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
              const Text(
                "Owner\'s Phone Number",
                style: TextStyle(fontSize: 20),
              ),
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
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 20),
                  ),
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
  const FactoryReader({super.key});

  @override
  State<FactoryReader> createState() => _FactoryReaderState();
}

class _FactoryReaderState extends State<FactoryReader> {
  late WebSocketChannel channel;
  late Stream stream;
  String connectionMessage = 'Connecting...';

  double voltageSensor = 0.0;
  double readingSteamPressure = 0.0;
  double readingSteamFlow = 0.0;
  double readingWaterLevel = 0.0;
  double readingPowerFrequency = 0.0;
  String readingDateTime = '--:--';

  @override
  void initState() {
    super.initState();
    connectWebSocket();
  }

  void connectWebSocket() {
    channel = WebSocketChannel.connect(
      Uri.parse('ws://123.253.32.26:4000/?piid='),
    );

    stream = channel.stream;

    channel.stream.listen(
      (message) {
        setState(() {
          updateSensorData(message);
        });
      },
      onDone: () {
        setState(() {
          connectionMessage = 'Controller is unreachable';
        });
      },
      onError: (error) {
        setState(() {
          connectionMessage = 'Error connecting to controller';
        });
      },
    );
  }

  void updateSensorData(String message) {
    Map<String, dynamic> data = jsonDecode(message);
    voltageSensor = data['voltageSensor'];
    readingSteamPressure = data['readingSteamPressure'];
    readingSteamFlow = data['readingSteamFlow'];
    readingWaterLevel = data['readingWaterLevel'];
    readingPowerFrequency = data['readingPowerFrequency'];
    readingDateTime = data['readingDateTime'];
  }

  @override
  void dispose() {
    channel.sink.close(status.normalClosure);
    super.dispose();
  }

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
              voltageSensor == 0 ? connectionMessage : '$voltageSensor kW',
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
                  value: readingSteamPressure,
                  unit: 'bar',
                ),
                _buildGaugeContainer(
                  title: 'Steam Flow',
                  value: readingSteamFlow,
                  unit: 'T/H',
                ),
                _buildGaugeContainer(
                  title: 'Water Level',
                  value: readingWaterLevel,
                  unit: '%',
                ),
                _buildGaugeContainer(
                  title: 'Power Frequency',
                  value: readingPowerFrequency,
                  unit: 'Hz',
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              readingDateTime,
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

class User {
  final String name;
  final String phone;

  User({required this.name, required this.phone});
}

List<User> users = [
  User(name: 'John Doe', phone: '+60123456789'),
  User(name: 'Jane Smith', phone: '+60198765432'),
];
