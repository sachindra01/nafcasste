// To parse this JSON data, do
//
//     final folderModel = folderModelFromJson(jsonString);

import 'dart:convert';

FolderModel folderModelFromJson(String str) => FolderModel.fromJson(json.decode(str));

String folderModelToJson(FolderModel data) => json.encode(data.toJson());

class FolderModel {
    int resultCode;
    String resultMessage;
    List<Datum> data;

    FolderModel({
        required this.resultCode,
        required this.resultMessage,
        required this.data,
    });

    factory FolderModel.fromJson(Map<String, dynamic> json) => FolderModel(
        resultCode: json["resultCode"],
        resultMessage: json["resultMessage"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resultCode": resultCode,
        "resultMessage": resultMessage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    List<String>? nodes;
    String id;
    String name;
    DateTime? createdAt;
    DateTime? lastUpdatedAt;

    Datum({
        this.nodes,
        required this.id,
        required this.name,
        this.createdAt,
        this.lastUpdatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        nodes: json["nodes"] == null ? [] : List<String>.from(json["nodes"]!.map((x) => x)),
        id: json["id"],
        name: json["name"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        lastUpdatedAt: json["lastUpdatedAt"] == null ? null : DateTime.parse(json["lastUpdatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "nodes": nodes == null ? [] : List<dynamic>.from(nodes!.map((x) => x)),
        "id": id,
        "name": name,
        "createdAt": createdAt?.toIso8601String(),
        "lastUpdatedAt": lastUpdatedAt?.toIso8601String(),
    };
}
