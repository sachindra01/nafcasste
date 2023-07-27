// To parse this JSON data, do
//
//     final favouritemodel = favouritemodelFromJson(jsonString);

import 'dart:convert';

List<Favouritemodel> favouritemodelFromJson(String str) => List<Favouritemodel>.from(json.decode(str).map((x) => Favouritemodel.fromJson(x)));

String favouritemodelToJson(List<Favouritemodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Favouritemodel {
    String ?image;
    List<String>? multiImage;
    List<dynamic>? categoryImgList;
    List<CoordinateListFav>? coordinateList;
    String ?name;
    String ?desc;
    String ?price;
    bool? creator;
    List<Color>? color;
    int? ratings;

    Favouritemodel({
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

    factory Favouritemodel.fromJson(Map<String, dynamic> json) => Favouritemodel(
        image: json["image"],
        multiImage: List<String>.from(json["multiImage"].map((x) => x)),
        categoryImgList: List<String>.from(json["categoryImgList"].map((x) => x)),
        coordinateList: List<CoordinateListFav>.from(json["coordinateList"].map((x) => CoordinateListFav.fromJson(x))),
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

class CoordinateListFav {
    double? x;
    double? y;

    CoordinateListFav({
        this.x,
        this.y,
    });

    factory CoordinateListFav.fromJson(Map<String, dynamic> json) => CoordinateListFav(
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
