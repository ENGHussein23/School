class Medalesmodel {
  String? id;
  String? name;
  String? image;
  String? selected;
  Medalesmodel(dynamic json) {
    id = json['id'].toString();
    name = json['name'].toString();

    image = json['image'].toString();
    selected = json['selected'].toString();
  }
}
