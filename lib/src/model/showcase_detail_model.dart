// To parse this JSON data, do
//
//     final showCaseDetailModel = showCaseDetailModelFromJson(jsonString);

import 'dart:convert';

ShowCaseDetailModel showCaseDetailModelFromJson(String str) => ShowCaseDetailModel.fromJson(json.decode(str));

String showCaseDetailModelToJson(ShowCaseDetailModel data) => json.encode(data.toJson());

class ShowCaseDetailModel {
    int? resultCode;
    String? resultMessage;
    Data? data;

    ShowCaseDetailModel({
        this.resultCode,
        this.resultMessage,
        this.data,
    });

    factory ShowCaseDetailModel.fromJson(Map<String, dynamic> json) => ShowCaseDetailModel(
        resultCode: json["resultCode"] ?? "",
        resultMessage: json["resultMessage"] ?? "",
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "resultCode": resultCode,
        "resultMessage": resultMessage,
        "data": data!.toJson(),
    };
}

class Data {
    String? creatorId;
    String? creatorName;
    String? createdAt;
    String? lastUpdatedAt;
    String? startDurationAt;
    String? endDurationAt;
    Profiles? profiles;
    List<dynamic>? nodes;
    String? id;
    String? name;

    Data({
        this.creatorId,
        this.creatorName,
        this.createdAt,
        this.lastUpdatedAt,
        this.startDurationAt,
        this.endDurationAt,
        this.profiles,
        this.nodes,
        this.id,
        this.name,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        creatorId: json["creatorId"] ?? "",
        creatorName: json["creatorName"] ?? "",
        createdAt:json["createdAt"] ?? "",
        lastUpdatedAt:json["lastUpdatedAt"] ?? "",
        startDurationAt:json["startDurationAt"] ?? "",
        endDurationAt:json["endDurationAt"] ?? "",
        profiles: Profiles.fromJson(json["profiles"]),
        nodes:json["nodes"] == null ? [] : List<dynamic>.from(json["nodes"].map((x) => x)),
        id: json["id"] ?? "",
        name: json["name"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "creatorId": creatorId,
        "creatorName": creatorName,
        "createdAt": createdAt,
        "lastUpdatedAt": lastUpdatedAt,
        "startDurationAt": startDurationAt,
        "endDurationAt": endDurationAt,
        "profiles": profiles!.toJson(),
        "nodes": List<dynamic>.from(nodes!.map((x) => x)),
        "id": id,
        "name": name,
    };
}

class Profiles {
    String? leafId;
    String? discription;
    List<FileElement>? files;
    List<String>? items;
    List<dynamic>? published;

    Profiles({
        this.leafId,
        this.discription,
        this.files,
        this.items,
        this.published,
    });

    factory Profiles.fromJson(Map<String, dynamic> json) => Profiles(
        leafId: json["leafId"] ?? "",
        discription: json["discription"] ?? "",
        files: json["files"] == null ? [] : List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
        items: json["items"] == null ? [] : List<String>.from(json["items"].map((x) => x)),
        published: json["published"] == null ? [] : List<dynamic>.from(json["published"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "leafId": leafId,
        "discription": discription,
        "files": List<dynamic>.from(files!.map((x) => x.toJson())),
        "items": List<dynamic>.from(items!.map((x) => x)),
        "published": List<dynamic>.from(published!.map((x) => x)),
    };
}

class FileElement {
    String? fileId;
    bool? representative;
    List<Pinned>? pinned;

    FileElement({
        this.fileId,
        this.representative,
        this.pinned,
    });

    factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        fileId: json["fileId"] ?? "",
        representative: json["representative"] ?? true,
        pinned: json["pinned"] == null ? [] :List<Pinned>.from(json["pinned"].map((x) => Pinned.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "fileId": fileId,
        "representative": representative,
        "pinned": List<dynamic>.from(pinned!.map((x) => x.toJson())),
    };
}

class Pinned {
    String? itemId;
    int? positionX;
    int? positionY;

    Pinned({
        this.itemId,
        this.positionX,
        this.positionY,
    });

    factory Pinned.fromJson(Map<String, dynamic> json) => Pinned(
        itemId: json["itemId"] ?? "",
        positionX: json["positionX"] ?? 180,
        positionY: json["positionY"] ?? 290,
    );

    Map<String, dynamic> toJson() => {
        "itemId": itemId,
        "positionX": positionX,
        "positionY": positionY,
    };
}
