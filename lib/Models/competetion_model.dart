import 'package:salateapp/globals.dart';

class Competetion{
  Data data=Data();
  late String message;
  late int status;
  Competetion();
  Competetion.fromJson(Map<String,dynamic> json){
    data = Data.fromJson(json['data']);
    message=json['message'];
    status=json['status'];
  }
}

class Data{
  late int id;
  late String name;
  late String description;
  late String how_to_win;
  late String colored_icon;
  late String gray_icon;
  late String status;
  Data();
  Data.fromJson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    description=json['description'];
    how_to_win=json['how_to_win'];
    colored_icon=API_Images_Url+json['colored_icon'];
    gray_icon=API_Images_Url+json['gray_icon'];
    status=json['status'];
  }
}