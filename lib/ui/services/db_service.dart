import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/result_model.dart';

class dbService {
  static dbService instance = dbService();
  late FirebaseFirestore _db;
  dbService() {
    _db = FirebaseFirestore.instance;
  }
  String _Doc = "result";
  Stream<resultModel>? getResult(String _ExamType, String _Board, String _Year,
      String _Roll, String _Reg) {
    try {
      var ref = _db
          .collection(_ExamType)
          .doc(_Board)
          .collection(_Year)
          .doc(_Reg)
          .collection(_Roll)
          .doc(_Doc);
      return ref!.get().asStream().map((_snap) {
        if (_snap.exists) {
          return resultModel.fromFirestore(_snap);
        } else {
          throw Exception("Result not found for given reg or roll number");
        }
      });
    } catch (e) {
      return Stream.error("Error : e");
    }
  }
}
