// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:eboard_result_queue/CustomWidgets/colors_names.dart';
import 'package:eboard_result_queue/ui/pages/Result_show.dart';

class homePage extends StatefulWidget {
  double deviceHeight;
  double devicWeight;
  homePage({
    Key? key,
    required this.deviceHeight,
    required this.devicWeight,
  }) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final _formkey = GlobalKey<FormState>();
  late String _selectedExamination;
  late String _selectedBoard;
  late String _selectedYear;
  late String _rollNo;
  late String _regNo;
  final List<String> examination = ["SSC", "HSC", "Dakhil"];
  final List<String> Boards = ["Dhaka", "Dinajpur", "Rajshahi", "Khulna"];
  final List<String> years =
      List<String>.generate(9, (index) => (2016 + index).toString());
  TextEditingController _rollController = TextEditingController();
  TextEditingController _regController = TextEditingController();
  double _changeSizeOfContainer = .60;
  @override
  void initState() {
    _changeSizeOfContainer = widget.deviceHeight < 557
        ? .75
        : widget.deviceHeight < 693
            ? .70
            : .60;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("height=$widget.deviceHeight");
    print(widget.devicWeight);

    print("sZ=$_changeSizeOfContainer");

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Education Board Result")),
      ),
      backgroundColor: ColorWidget.instance.scafoldBackColor,
      body: SingleChildScrollView(
          child: Align(alignment: Alignment.topCenter, child: _homeUI())),
    );
  }

  Widget _homeUI() {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      height: widget.deviceHeight * .90,
      width: widget.devicWeight * .95,
      color: const Color.fromARGB(113, 6, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _titleText(),
          SizedBox(
            height: widget.devicWeight * .02,
          ),
          _inputForm(),
        ],
      ),
    );
  }

  Widget _titleText() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.only(top: widget.deviceHeight * .03),
        height: widget.deviceHeight * .10,
        width: widget.devicWeight * .95,
        color: const Color.fromARGB(42, 245, 240, 240),
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
          padding: EdgeInsets.only(top: widget.deviceHeight * .01),
          height: widget.deviceHeight * _changeSizeOfContainer,
          width: widget.devicWeight * .93,
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
                    _selectedExamination = _selectedItem!;
                  });
                }),
                _makeSpace(),
                _buildDropDownFields("Year", years, (_InputYear) {
                  setState(() {
                    _selectedYear = _InputYear!;
                  });
                }),
                _makeSpace(),
                _buildDropDownFields("Board", Boards, (_input) {
                  setState(() {
                    _selectedBoard = _input!;
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
      height: widget.deviceHeight * .05,
      width: widget.devicWeight * .60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red),
      ),
      child: const Center(
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
        padding: const EdgeInsets.symmetric(vertical: 2.0),
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
                    labelStyle: const TextStyle(color: Colors.white),
                    border: const OutlineInputBorder(),
                  ),
                  items: items.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
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
        const SizedBox(width: 8),
        Center(
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            width: widget.devicWeight * .30,
            height: widget.deviceHeight * .05,
            // color: Colors.white,
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
    return Row(
      children: [
        _LableText(label),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Enter Your $label",
              border: const OutlineInputBorder(),
              labelStyle: const TextStyle(
                color: Colors.white,
              ),
            ),
            style: const TextStyle(color: Colors.white),
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
    );
  }

  Widget _submitAndResetButton() {
    return Row(
      children: [
        SizedBox(
          width: widget.devicWeight * .30,
        ),
        ElevatedButton(
          onPressed: () {
            _submitForm();
          },
          child: const Text("Submit"),
        ),
        SizedBox(
          width: widget.devicWeight * .10,
        ),
        ElevatedButton(
            onPressed: () {
              _resetForm();
            },
            child: const Text("Reset"))
      ],
    );
  }

  Widget _makeSpace() {
    return SizedBox(
      height: widget.deviceHeight * .01,
    );
  }

  void _submitForm() {
    if (_formkey.currentState?.validate() ?? false) {
      setState(() {
        _rollNo = _rollController.text;
        _regNo = _regController.text;
      });

      Get.to(ResultPage(
        selectedExamination: _selectedExamination,
        selectedBoard: _selectedBoard,
        selectedYear: _selectedYear,
        rollNo: _rollNo,
        regNo: _regNo,
        deviceHeight: widget.deviceHeight,
        devicWeight: widget.devicWeight,
      ));
    } else {
      if (widget.deviceHeight > 693) {
        setState(() {
          _changeSizeOfContainer = .70;
        });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                    "please Enter a valid Roll and Reg And select a valid option"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      _resetForm();
                      navigator!.pop(context);
                    },
                    child: Text("Reset"),
                  )
                ],
              );
            });
      }
    }
  }

  void _resetForm() {
    _formkey.currentState?.reset();
    setState(() {
      _selectedExamination = "";
      _selectedYear = "";
      _selectedBoard = "";
      _rollController.clear();
      _regController.clear();
      _changeSizeOfContainer = widget.deviceHeight < 557
          ? .75
          : widget.deviceHeight < 693
              ? .70
              : .60;
    });
  }
}
