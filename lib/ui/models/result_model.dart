import 'package:cloud_firestore/cloud_firestore.dart';

class resultModel {
  final String name;
  final String result;
  final String subject;
  resultModel({
    required this.name,
    required this.result,
    required this.subject,
  });
  factory resultModel.fromFirestore(DocumentSnapshot snapshot) {
    var _data = snapshot.data() as Map<String, dynamic>;
    return resultModel(
      name: _data["name"],
      result: _data["Result"],
      subject: _data["subject"],
    );
  }
}
