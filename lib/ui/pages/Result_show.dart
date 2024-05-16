// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:eboard_result_queue/ui/models/result_model.dart';
import 'package:eboard_result_queue/ui/services/db_service.dart';
import 'package:flutter/material.dart';

import 'package:eboard_result_queue/CustomWidgets/colors_names.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ResultPage extends StatefulWidget {
  String? selectedExamination;
  String? selectedBoard;
  String? selectedYear;
  String rollNo;
  String regNo;
  double deviceHeight;
  double devicWeight;
  ResultPage({
    required this.selectedExamination,
    required this.selectedBoard,
    required this.selectedYear,
    required this.rollNo,
    required this.regNo,
    required this.deviceHeight,
    required this.devicWeight,
  });
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late Stream<resultModel?> _resultStream;
  @override
  void initState() {
    _resultStream = dbService.instance.getResult(
      widget.selectedExamination!,
      widget.selectedBoard!,
      widget.selectedYear!,
      widget.rollNo,
      widget.regNo,
    )!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Page'),
      ),
      backgroundColor: ColorWidget.instance.scafoldBackColor,
      body: StreamBuilder<resultModel?>(
          stream: _resultStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SpinKitRotatingPlain(
                color: Colors.yellow,
                size: widget.devicWeight * .60,
              );
            } else if (snapshot.hasError) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Get.snackbar("Error", "please check registration and roll");
              });
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitChasingDots(
                      color: Colors.yellow,
                      size: widget.devicWeight * .20,
                    ),
                    SizedBox(
                      height: widget.deviceHeight * .10,
                    ),
                    const Text(
                      "please check registration and roll",
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                    SizedBox(
                      height: widget.deviceHeight * .05,
                    ),
                    _backButton()
                  ],
                ),
              );
            } else if (!snapshot.hasData) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Get.snackbar("error", "Result not found");
              });
              return Center(
                child: Text("Result not found"),
              );
            }
            final _result = snapshot.data;

            return SingleChildScrollView(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  color: Color.fromARGB(112, 1, 1, 1),
                  child: Column(
                    children: [
                      _buildResultRow('Roll', widget.rollNo),
                      _buildResultRow('Name', _result!.name),
                      _buildResultRow('Registration', widget.regNo),
                      _buildResultRow('Year', widget.selectedYear!),
                      _buildResultRow('Board', widget.selectedBoard!),
                      _buildResultRow('Subjects', _result.subject),
                      _buildResultRow('Result', _result!.result),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _backButton() {
    return ElevatedButton(
      onPressed: () {
        Get.back();
      },
      child: Text("BACK"),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 18, color: Colors.white),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
