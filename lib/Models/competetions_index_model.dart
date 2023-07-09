import 'dart:convert';

import '../globals.dart';

class AllCompetitions {
  late int status;
  late String message;
  Data data=Data();
  AllCompetitions();
  AllCompetitions.fromJson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
    data=Data.fromJson(json['data']);
  }
}
class Data{
  List<IndexCompetition> won=[];
  List<IndexCompetition> other=[];
  Data();
  Data.fromJson(Map<String,dynamic> json){
    won=[];
    if (json["won"] != null) {
      won = (json["won"] as List)
          .map((item) => IndexCompetition.fromJson(item))
          .toList();
    } else {
      won = [];
    }
    other=[];
    if (json["other"] != null) {
      other = (json["other"] as List)
          .map((item) => IndexCompetition.fromJson(item))
          .toList();
    } else {
      other = [];
    }
  }
}
class IndexCompetition{
  late int id;
  late String icon;
  IndexCompetition.fromJson(Map<String,dynamic> json){
    id=json['id'];
    icon=API_Images_Url+json['icon'];
  }
}