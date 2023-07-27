// To parse this JSON data, do
//
//     final searchmodel = searchmodelFromJson(jsonString);

import 'dart:convert';

List<Searchmodel> searchmodelFromJson(String str) => List<Searchmodel>.from(json.decode(str).map((x) => Searchmodel.fromJson(x)));

String searchmodelToJson(List<Searchmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Searchmodel {
    String? image;
    List<String>? multiImage;
    List<String> categoryImgList;
    List<CoordinateList>? coordinateList;
    String? name;
    String? desc;
    String? price;
    bool? creator;
    List<Color>? color;
    int? ratings;

    Searchmodel({
        this.image,
        this.multiImage,
        required this.categoryImgList,
        this.coordinateList,
        this.name,
        this.desc,
        this.price,
        this.creator,
        this.color,
        this.ratings,
    });

    factory Searchmodel.fromJson(Map<String, dynamic> json) => Searchmodel(
        image: json["image"],
        multiImage: List<String>.from(json["multiImage"].map((x) => x)),
        categoryImgList: List<String>.from(json["categoryImgList"].map((x) => x)),
        coordinateList: List<CoordinateList>.from(json["coordinateList"].map((x) => CoordinateList.fromJson(x))),
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
        "categoryImgList": List<dynamic>.from(categoryImgList.map((x) => x)),
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

class CoordinateList {
    double? x;
    double? y;

    CoordinateList({
        this.x,
        this.y,
    });

    factory CoordinateList.fromJson(Map<String, dynamic> json) => CoordinateList(
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
