
import 'dart:convert';

FavoriteshowModel favoriteshowModelFromJson(String str) => FavoriteshowModel.fromJson(json.decode(str));

String favoriteshowModelToJson(FavoriteshowModel data) => json.encode(data.toJson());

class FavoriteshowModel {
    int resultCode;
    String resultMessage;
    List<Datum> data;

    FavoriteshowModel({
        required this.resultCode,
        required this.resultMessage,
        required this.data,
    });

    FavoriteshowModel copyWith({
        int? resultCode,
        String? resultMessage,
        List<Datum>? data,
    }) => 
        FavoriteshowModel(
            resultCode: resultCode ?? this.resultCode,
            resultMessage: resultMessage ?? this.resultMessage,
            data: data ?? this.data,
        );

    factory FavoriteshowModel.fromJson(Map<String, dynamic> json) => FavoriteshowModel(
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
    String? creatorId;
    String? creatorName;
    DateTime? createdAt;
    DateTime? lastUpdatedAt;
    DateTime? startDurationAt;
    DateTime? endDurationAt;
    Profiles profiles;
    List<dynamic>? nodes;
    String id;
    String name;
    String? parentId;

    Datum({
        this.creatorId,
        this.creatorName,
        this.createdAt,
        this.lastUpdatedAt,
        this.startDurationAt,
        this.endDurationAt,
        required this.profiles,
        this.nodes,
        required this.id,
        required this.name,
        this.parentId,
    });

    Datum copyWith({
        String? creatorId,
        String? creatorName,
        DateTime? createdAt,
        DateTime? lastUpdatedAt,
        DateTime? startDurationAt,
        DateTime? endDurationAt,
        Profiles? profiles,
        List<dynamic>? nodes,
        String? id,
        String? name,
        String? parentId,
    }) => 
        Datum(
            creatorId: creatorId ?? this.creatorId,
            creatorName: creatorName ?? this.creatorName,
            createdAt: createdAt ?? this.createdAt,
            lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
            startDurationAt: startDurationAt ?? this.startDurationAt,
            endDurationAt: endDurationAt ?? this.endDurationAt,
            profiles: profiles ?? this.profiles,
            nodes: nodes ?? this.nodes,
            id: id ?? this.id,
            name: name ?? this.name,
            parentId: parentId ?? this.parentId,
        );

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        creatorId: json["creatorId"],
        creatorName: json["creatorName"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        lastUpdatedAt: json["lastUpdatedAt"] == null ? null : DateTime.parse(json["lastUpdatedAt"]),
        startDurationAt: json["startDurationAt"] == null ? null : DateTime.parse(json["startDurationAt"]),
        endDurationAt: json["endDurationAt"] == null ? null : DateTime.parse(json["endDurationAt"]),
        profiles: Profiles.fromJson(json["profiles"]),
        nodes: json["nodes"] == null ? [] : List<dynamic>.from(json["nodes"]!.map((x) => x)),
        id: json["id"],
        name: json["name"],
        parentId: json["parentId"],
    );

    Map<String, dynamic> toJson() => {
        "creatorId": creatorId,
        "creatorName": creatorName,
        "createdAt": createdAt?.toIso8601String(),
        "lastUpdatedAt": lastUpdatedAt?.toIso8601String(),
        "startDurationAt": startDurationAt?.toIso8601String(),
        "endDurationAt": endDurationAt?.toIso8601String(),
        "profiles": profiles.toJson(),
        "nodes": nodes == null ? [] : List<dynamic>.from(nodes!.map((x) => x)),
        "id": id,
        "name": name,
        "parentId": parentId,
    };
}

class Profiles {
    String leafId;
    String discription;
    String?image;
    List<FileElement> files;
    List<String>? items;
    List<dynamic>? published;

    Profiles({
        required this.leafId,
        required this.discription,
        required this.files,
        this.items,
        this.published,
        this.image,
    });

    Profiles copyWith({
        String? leafId,
        String? discription,
        List<FileElement>? files,
        List<String>? items,
        List<dynamic>? published,
    }) => 
        Profiles(
            leafId: leafId ?? this.leafId,
            discription: discription ?? this.discription,
            files: files ?? this.files,
            items: items ?? this.items,
            published: published ?? this.published,
        );

    factory Profiles.fromJson(Map<String, dynamic> json) => Profiles(
        leafId: json["leafId"],
        discription: json["discription"],
        image: json["image"],
        files: List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
        items: json["items"] == null ? [] : List<String>.from(json["items"]!.map((x) => x)),
        published: json["published"] == null ? [] : List<dynamic>.from(json["published"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "leafId": leafId,
        "discription": discription,
        "image": image,
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x)),
        "published": published == null ? [] : List<dynamic>.from(published!.map((x) => x)),
    };
}

class FileElement {
    String fileId;
    bool representative;
    List<Pinned> pinned;

    FileElement({
        required this.fileId,
        required this.representative,
        required this.pinned,
    });

    FileElement copyWith({
        String? fileId,
        bool? representative,
        List<Pinned>? pinned,
    }) => 
        FileElement(
            fileId: fileId ?? this.fileId,
            representative: representative ?? this.representative,
            pinned: pinned ?? this.pinned,
        );

    factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        fileId: json["fileId"],
        representative: json["representative"],
        pinned: List<Pinned>.from(json["pinned"].map((x) => Pinned.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "fileId": fileId,
        "representative": representative,
        "pinned": List<dynamic>.from(pinned.map((x) => x.toJson())),
    };
}

class Pinned {
    String itemId;
    int positionX;
    int positionY;

    Pinned({
        required this.itemId,
        required this.positionX,
        required this.positionY,
    });

    Pinned copyWith({
        String? itemId,
        int? positionX,
        int? positionY,
    }) => 
        Pinned(
            itemId: itemId ?? this.itemId,
            positionX: positionX ?? this.positionX,
            positionY: positionY ?? this.positionY,
        );

    factory Pinned.fromJson(Map<String, dynamic> json) => Pinned(
        itemId: json["itemId"],
        positionX: json["positionX"],
        positionY: json["positionY"],
    );

    Map<String, dynamic> toJson() => {
        "itemId": itemId,
        "positionX": positionX,
        "positionY": positionY,
    };
}
