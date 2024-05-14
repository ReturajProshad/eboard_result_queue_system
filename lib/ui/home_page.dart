import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late double _deviceHeight;
  late double _devicWeight;
  final _formkey = GlobalKey<FormState>();
  String? _selectedExamination;
  String? _selectedBoard;
  String? _selectedYear;
  final List<String> examination = ["SSC", "HSC", "Dakhil"];
  final List<String> Boards = ["Dhaka", "Dinajpur", "Rajshahi", "Khulna"];
  final List<String> years =
      List<String>.generate(9, (index) => (2016 + index).toString());
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _devicWeight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("E REsult")),
      ),
      backgroundColor: Color.fromARGB(41, 0, 254, 38),
      body: Align(alignment: Alignment.topCenter, child: _homeUI()),
    );
  }

  Widget _homeUI() {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      height: _deviceHeight * .90,
      width: _devicWeight * .95,
      color: Color.fromARGB(113, 6, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _titleText(),
          SizedBox(
            height: _devicWeight * .02,
          ),
          _inputForm()
        ],
      ),
    );
  }

  Widget _titleText() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.only(top: _deviceHeight * .03),
        height: _deviceHeight * .10,
        width: _devicWeight * .95,
        color: Color.fromARGB(42, 245, 240, 240),
        child: const Text(
          "Welcome To Your Result Section",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }

  Widget _inputForm() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
          padding: EdgeInsets.only(top: _deviceHeight * .03),
          height: _deviceHeight * .40,
          width: _devicWeight * .93,
          decoration: BoxDecoration(
            color: Color.fromARGB(104, 4, 19, 224),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.blue, // Border color
              width: 4.0, // Border width
            ),
          ),
          child: Column(
            children: [],
          )),
    );
  }

  Widget _buildDropDownFields(
      String? lable, List<String> items, Function(String?) onChanged) {
    return Padding(padding: EdgeInsets.symmetric(vertical: 8.0));
  }
}
