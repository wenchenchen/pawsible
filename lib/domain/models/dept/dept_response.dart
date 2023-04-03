// To parse this JSON data, do
//
//     final deptResponse = deptResponseFromJson(jsonString);
import 'dart:convert';
import 'dept.dart';

DeptResponse deptResponseFromJson(String str) => DeptResponse.fromJson(json.decode(str));

String deptResponseToJson(DeptResponse data) => json.encode(data.toJson());

class DeptResponse {
  DeptResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final int status;
  final dynamic message;
  final List<Dept> data;

  factory DeptResponse.fromJson(Map<String, dynamic> json) => DeptResponse(
    status: json["status"],
    message: json["message"],
    data: List<Dept>.from(json["data"].map((x) => Dept.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
