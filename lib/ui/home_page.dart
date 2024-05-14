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
  String? _rollNo;
  String? _regNo;
  final List<String> examination = ["SSC", "HSC", "Dakhil"];
  final List<String> Boards = ["Dhaka", "Dinajpur", "Rajshahi", "Khulna"];
  final List<String> years =
      List<String>.generate(9, (index) => (2016 + index).toString());
  TextEditingController _rollController = TextEditingController();
  TextEditingController _regController = TextEditingController();
  double _changeSizeOfContainer = .60;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _devicWeight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Education Board Result")),
      ),
      backgroundColor: Color.fromARGB(41, 0, 254, 38),
      body: SingleChildScrollView(
          child: Align(alignment: Alignment.topCenter, child: _homeUI())),
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
          height: _deviceHeight * _changeSizeOfContainer,
          width: _devicWeight * .93,
          decoration: BoxDecoration(
            //color: Color.fromARGB(104, 4, 19, 224),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.blue, // Border color
              width: 4.0, // Border width
            ),
          ),
          child: Form(
            key: _formkey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.max,
              children: [
                _buildDropDownFields("Examination", examination,
                    (_selectedItem) {
                  setState(() {
                    _selectedExamination = _selectedItem;
                  });
                }),
                _makeSpace(),
                _buildDropDownFields("Year", years, (_InputYear) {
                  setState(() {
                    _selectedYear = _InputYear;
                  });
                }),
                _makeSpace(),
                _buildDropDownFields("Board", Boards, (_input) {
                  setState(() {
                    _selectedBoard = _input;
                  });
                }),
                _makeSpace(),
                _buildTextField("Roll", _rollController),
                _makeSpace(),
                _buildTextField("Registration", _regController),
                _makeSpace(),
                _submitAndResetButton(),
                _makeSpace(),
                _PoweredByMessage(),
              ],
            ),
          )),
    );
  }

  Container _PoweredByMessage() {
    return Container(
      height: _deviceHeight * .05,
      width: _devicWeight * .60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red),
      ),
      child: Center(
        child: Text(
          "powered By Firebase",
          style: TextStyle(fontSize: 25, color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildDropDownFields(
      String lable, List<String> items, Function(String?) onChanged) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            _LableText(lable),
            Expanded(
              child: Theme(
                data: Theme.of(context)
                    .copyWith(canvasColor: const Color.fromARGB(255, 0, 0, 0)),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Select $lable",
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                  items: items.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                  validator: (value) =>
                      value == null ? 'Please select a $lable' : null,
                ),
              ),
            ),
          ],
        ));
  }

  Widget _LableText(String label) {
    return Row(
      children: [
        SizedBox(width: 8),
        Center(
          child: Container(
            padding: EdgeInsets.only(top: 10),
            width: _devicWeight * .30,
            height: _deviceHeight * .05,
            //color: Colors.white,
            child: Text(
              label,
              style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
        ),
        const Text(
          ":",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController _controller) {
    return Container(
      child: Row(
        children: [
          _LableText(label),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Enter Your $label",
                border: OutlineInputBorder(),
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: TextStyle(color: Colors.white),
              controller: _controller,
              validator: (_input) {
                if (_input == null || _input.isEmpty) {
                  return 'Please enter your $label';
                } else if (int.tryParse(_input) == null) {
                  return 'Please enter a valid number for $label';
                }
                return null;
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _submitAndResetButton() {
    return Row(
      children: [
        SizedBox(
          width: _devicWeight * .30,
        ),
        ElevatedButton(
          onPressed: () {
            _submitForm();
          },
          child: Text("Submit"),
        ),
        SizedBox(
          width: _devicWeight * .10,
        ),
        ElevatedButton(
            onPressed: () {
              _resetForm();
            },
            child: Text("Reset"))
      ],
    );
  }

  Widget _makeSpace() {
    return SizedBox(
      height: _deviceHeight * .01,
    );
  }

  void _submitForm() {
    if (_formkey.currentState?.validate() ?? false) {
      // Process the form data
      print("Form submitted");
    } else {
      _changeSizeOfContainer = .75;
      setState(() {});
    }
  }

  void _resetForm() {
    _formkey.currentState?.reset();
    setState(() {
      _selectedExamination = null;
      _selectedYear = null;
      _selectedBoard = null;
      _rollController.clear();
      _regController.clear();
      _changeSizeOfContainer = .60;
    });
  }
}
