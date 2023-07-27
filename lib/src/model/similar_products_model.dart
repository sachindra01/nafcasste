// To parse this JSON data, do
//
//     final similarProductsModel = similarProductsModelFromJson(jsonString);

import 'dart:convert';

SimilarProductsModel similarProductsModelFromJson(String str) => SimilarProductsModel.fromJson(json.decode(str));

String similarProductsModelToJson(SimilarProductsModel data) => json.encode(data.toJson());

class SimilarProductsModel {
    int? resultCode;
    String? resultMessage;
    Data? data;

    SimilarProductsModel({
        this.resultCode,
        this.resultMessage,
        this.data,
    });

    factory SimilarProductsModel.fromJson(Map<String, dynamic> json) => SimilarProductsModel(
        resultCode: json["resultCode"],
        resultMessage: json["resultMessage"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "resultCode": resultCode,
        "resultMessage": resultMessage,
        "data": data!.toJson(),
    };
}

class Data {
    String? garageId;
    String? leafId;
    String? groupId;
    String? productId;
    String? leafProductId;
    String? createdDateTime;
    String? updatedDateTime;
    String? createdAccountId;
    String? updatedAccountId;
    Items? items;
    List<FileElement>? files;
    dynamic tags;
    dynamic status;

    Data({
        this.garageId,
        this.leafId,
        this.groupId,
        this.productId,
        this.leafProductId,
        this.createdDateTime,
        this.updatedDateTime,
        this.createdAccountId,
        this.updatedAccountId,
        this.items,
        this.files,
        this.tags,
        this.status,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        garageId: json["garageId"],
        leafId: json["leafId"],
        groupId: json["groupId"],
        productId: json["productId"],
        leafProductId: json["leafProductId"],
        createdDateTime: json["createdDateTime"],
        updatedDateTime: json["updatedDateTime"],
        createdAccountId: json["createdAccountId"],
        updatedAccountId: json["updatedAccountId"],
        items: Items.fromJson(json["items"]),
        files: List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
        tags: json["tags"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "garageId": garageId,
        "leafId": leafId,
        "groupId": groupId,
        "productId": productId,
        "leafProductId": leafProductId,
        "createdDateTime": createdDateTime,
        "updatedDateTime": updatedDateTime,
        "createdAccountId": createdAccountId,
        "updatedAccountId": updatedAccountId,
        "items": items!.toJson(),
        "files": List<dynamic>.from(files!.map((x) => x.toJson())),
        "tags": tags,
        "status": status,
    };
}

class FileElement {
    String? leafFileId;
    int? displayOrder;
    int? fileboxFileId;
    String? fileboxFileLinkId;
    String? mimeType;
    String? fileName;
    dynamic comment;

    FileElement({
        this.leafFileId,
        this.displayOrder,
        this.fileboxFileId,
        this.fileboxFileLinkId,
        this.mimeType,
        this.fileName,
        this.comment,
    });

    factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        leafFileId: json["leafFileId"],
        displayOrder: json["displayOrder"],
        fileboxFileId: json["fileboxFileId"],
        fileboxFileLinkId: json["fileboxFileLinkId"],
        mimeType: json["mimeType"],
        fileName: json["fileName"],
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "leafFileId": leafFileId,
        "displayOrder": displayOrder,
        "fileboxFileId": fileboxFileId,
        "fileboxFileLinkId": fileboxFileLinkId,
        "mimeType": mimeType,
        "fileName": fileName,
        "comment": comment,
    };
}

class Items {
    String? privateCd;
    String? officialCd;
    String? productGroupCd;
    String? parentProductCd;
    String? productName;

    Items({
        this.privateCd,
        this.officialCd,
        this.productGroupCd,
        this.parentProductCd,
        this.productName,
    });

    factory Items.fromJson(Map<String, dynamic> json) => Items(
        privateCd: json["privateCd"],
        officialCd: json["officialCd"],
        productGroupCd: json["productGroupCd"],
        parentProductCd: json["parentProductCd"],
        productName: json["productName"],
    );

    Map<String, dynamic> toJson() => {
        "privateCd": privateCd,
        "officialCd": officialCd,
        "productGroupCd": productGroupCd,
        "parentProductCd": parentProductCd,
        "productName": productName,
    };
}
