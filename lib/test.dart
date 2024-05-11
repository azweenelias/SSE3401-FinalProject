// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyFactoryPage extends StatefulWidget {
  const MyFactoryPage({super.key});

  @override
  State<MyFactoryPage> createState() => _MyFactoryPageState();
}

class _MyFactoryPageState extends State<MyFactoryPage> {
  int currentIndex = 1;
  String appBarTitle = 'Factory 1'; // have better solution on not to delcare 1?
  int currentFactoryNumber = 1; // can alter all to this
  // int onTapFactoryButton = 0;
  List<String> engineers = ['Ben', 'Testing 1', 'Hello'];
  List<String> engineerPhoneNo = [
    '+60109219938',
    '+601234567891',
    '+60123456789'
  ];

  void updateAppBarTitle(int factoryNumber) {
    setState(() {
      appBarTitle = 'Factory $factoryNumber';
    });
    // return factoryNumber;
  }

  void displayFactoryPage(int factoryNumber) {
    setState(() {
      currentFactoryNumber = factoryNumber;
    });
  }

  // void addOnTopShadow(int factoryNumber) {
  //   setState(() {
  //     onTapFactoryButton = factoryNumber;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          appBarTitle,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              size: 30,
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade500,
          ),
          child: Column(
            children: [
              Container(
                width: 380,
                height: 520,
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: currentIndex == 1
                    ? currentFactoryNumber == 1
                        ? const FactoryContext(
                            '⚠ABD1234 IS UNREACHABLE !',
                            '0.0',
                            '0.0',
                            '0.0',
                            '0.0',
                            'images/F1.1.png',
                            'images/F1.2.png',
                            'images/F1.3.png',
                            'images/F1.4.png',
                            '--:--')
                        : currentFactoryNumber == 2
                            ? const FactoryContext(
                                '1549.6kW',
                                '34.19',
                                '22.82',
                                '55.41',
                                '50.08',
                                'images/F2.1.png',
                                'images/F2.2.png',
                                'images/F2.3.png',
                                'images/F2.4.png',
                                '2024-04-26 13:45:25')
                            : const FactoryContext(
                                '⚠ABD1234 IS UNREACHABLE !',
                                '0.0',
                                '0.0',
                                '0.0',
                                '0.0',
                                'images/F1.1.png',
                                'images/F1.2.png',
                                'images/F1.3.png',
                                'images/F1.4.png',
                                '--:--')
                    : currentIndex == 0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: engineers.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ListTile(
                                            tileColor: Colors.white,
                                            title: Row(
                                              children: [
                                                const SizedBox(width: 21.0),
                                                Text(
                                                  engineers[index],
                                                  style: const TextStyle(
                                                      fontSize: 23),
                                                ),
                                              ],
                                            ),
                                            subtitle: Row(
                                              children: [
                                                const Icon(
                                                  Icons.circle,
                                                  size: 15,
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  engineerPhoneNo[index],
                                                  style: const TextStyle(
                                                      fontSize: 23),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.purple.shade200,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    // child: IconButton(
                                    //   onPressed: () {
                                    //     Navigator.of(context).push(
                                    //       MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const Invitation(),
                                    //       ),
                                    //     );
                                    //   },
                                    //   icon: const Icon(
                                    //     Icons.add,
                                    //     size: 35,
                                    //   ),
                                    // ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Minimum Threshold',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.info_outline_rounded,
                                        size: 25,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 70,
                                      child: IconButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                        ),
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.purple.shade700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Expanded(
                                  child: GridView.count(
                                    crossAxisCount: 2,
                                    primary: true,
                                    children: <Widget>[
                                      EditData('Steam\nPressure', '29', 'bar'),
                                      EditData('Steam\nFlow', '22', 'T/H'),
                                      EditData('Water\nLevel', '53', '%'),
                                      EditData('Power\nLevel', '48', 'Hz'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FactoryButton(
                      1,
                      () {
                        updateAppBarTitle(1);
                        displayFactoryPage(1);
                      },
                    ),
                    FactoryButton(
                      2,
                      () {
                        updateAppBarTitle(2);
                        displayFactoryPage(2);
                      },
                    ),
                    FactoryButton(
                      3,
                      () {
                        updateAppBarTitle(3);
                        displayFactoryPage(3);
                      },
                    ), // a bit redundance
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 30),
            label: '',
          ),
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

class EditData extends StatelessWidget {
  String editDataTitle;
  String editData;
  String editDataUnit;

  EditData(this.editDataTitle, this.editData, this.editDataUnit, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          Text(
            editDataTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
                  child: Text(
                    editData,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                Container(
                  height: 56,
                  width: 2,
                  color: Colors.black,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Text(
                    editDataUnit,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FactoryContext extends StatefulWidget {
  final String contextTitle;
  final String data1;
  final String data2;
  final String data3;
  final String data4;
  final String img1;
  final String img2;
  final String img3;
  final String img4;
  final String timeStamp;

  const FactoryContext(this.contextTitle, this.data1, this.data2, this.data3,
      this.data4, this.img1, this.img2, this.img3, this.img4, this.timeStamp,
      {Key? key})
      : super(key: key);

  @override
  State<FactoryContext> createState() => _FactoryContextState();
}

class _FactoryContextState extends State<FactoryContext> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
          child: Text(
            widget.contextTitle,
            style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            crossAxisSpacing: 8,
            mainAxisSpacing: 23,
            crossAxisCount: 2,
            children: <Widget>[
              DataContainer('Steam Pressure', widget.img1, widget.data1, 'bar'),
              DataContainer('Steam Flow', widget.img2, widget.data2, 'T/H'),
              DataContainer('Water Level', widget.img3, widget.data3, '%'),
              DataContainer('Power Frequency', widget.img4, widget.data4, 'Hz'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            widget.timeStamp,
            style: const TextStyle(fontSize: 22),
          ),
        ),
      ],
    );
  }
}

class DataContainer extends StatelessWidget {
  final String dataTitle;
  final String image;
  final String data;
  final String dataUnit;

  const DataContainer(this.dataTitle, this.image, this.data, this.dataUnit,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              textAlign: TextAlign.center,
              dataTitle,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Image.asset(
            image,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 27.0),
              ),
              Text(
                dataUnit,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FactoryButton extends StatelessWidget {
  final int factoryNumber;
  final VoidCallback onTap;
  final bool selected = false;
  // int onTapFactoryButton = 0;

  const FactoryButton(this.factoryNumber, this.onTap, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 130, // use pixel?
        width: 175,

        decoration: BoxDecoration(
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.blue.shade700.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 3,
                  ),
                ]
              : [],
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Icon(
                Icons.factory,
                size: 35,
              ),
            ),
            Text(
              'Factory $factoryNumber',
              style: const TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}