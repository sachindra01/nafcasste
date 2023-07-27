// To parse this JSON data, do
//
//     final collectionmodel = collectionmodelFromJson(jsonString);

import 'dart:convert';

List<Collectionmodel> collectionmodelFromJson(String str) => List<Collectionmodel>.from(json.decode(str).map((x) => Collectionmodel.fromJson(x)));

String collectionmodelToJson(List<Collectionmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Collectionmodel {
    String ?image;
    List<String>? multiImage;
    List<String>? categoryImgList;
    List<CoordinateListCol>? coordinateList;
    String ?name;
    String ?desc;
    String ?price;
    bool? creator;
    List<Color>? color;
    int? ratings;

    Collectionmodel({
        this.image,
        this.multiImage,
        this.categoryImgList,
        this.coordinateList,
        this.name,
        this.desc,
        this.price,
        this.creator,
        this.color,
        this.ratings,
    });

    factory Collectionmodel.fromJson(Map<String, dynamic> json) => Collectionmodel(
        image: json["image"],
        multiImage: List<String>.from(json["multiImage"].map((x) => x)),
        categoryImgList: List<String>.from(json["categoryImgList"].map((x) => x)),
        coordinateList: List<CoordinateListCol>.from(json["coordinateList"].map((x) => CoordinateListCol.fromJson(x))),
        name: json["name"],
        desc: json["desc"],
        price: json["price"],
        creator: json["creator"],
        color: List<Color>.from(json["color"].map((x) => colorValues.map[x])),
        ratings: json["ratings"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
        "multiImage": List<dynamic>.from(multiImage!.map((x) => x)),
        "categoryImgList": List<dynamic>.from(categoryImgList!.map((x) => x)),
        "coordinateList": List<dynamic>.from(coordinateList!.map((x) => x.toJson())),
        "name": name,
        "desc": desc,
        "price": price,
        "creator": creator,
        "color": List<dynamic>.from(color!.map((x) => colorValues.reverse[x])),
        "ratings": ratings,
    };
}

enum Color { brown, natural }

final colorValues = EnumValues({
    "brown": Color.brown,
    "natural": Color.natural
});

class CoordinateListCol {
    double? x;
    double? y;

    CoordinateListCol({
        this.x,
        this.y,
    });

    factory CoordinateListCol.fromJson(Map<String, dynamic> json) => CoordinateListCol(
        x: json["x"].toDouble(),
        y: json["y"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
