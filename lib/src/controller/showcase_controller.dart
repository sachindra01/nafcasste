import 'dart:developer';
import 'package:get/get.dart';
import 'package:nafcassete/src/helpers/constant.dart';
import 'package:nafcassete/src/helpers/read_write.dart';
import 'package:nafcassete/src/helpers/repository.dart';
import 'package:nafcassete/src/model/showcase_detail_model.dart';
import 'package:nafcassete/src/model/showcase_model.dart';
import 'package:nafcassete/src/widgets/custom_toast.dart';
import 'package:nafcassete/src/widgets/loading_widget.dart';

class ShowCaseController extends GetxController{
  dynamic showCaseData = [];
  dynamic showCaseDetailImg = [];
  dynamic showCaseDetailDesc = [];
  dynamic showCaseDetailsPinned = [];
  List similarItems = [];
  List coordinatingImg = [];
  var showcaseLoading = false.obs;
  var showcaseDetailLoading = false.obs;
  var showcaseCoordinatingLoading = false.obs;

  // 1-1 ShowCaseList
  getShowcaseList() async {
    try {
      showcaseLoading(true);
      var response = await ApiRepo.apiGet('${garageProposalOApi}v1.0/cassette/${read('leafId')}/${read('areaId')}/list','','1-1_カセットリスト取得 #Showcase List');
      if(response != null && response['resultCode'] == 0) {
        final data = ShowCaseModel.fromJson(response);
        for(var item in data.data!) {
          for(var file in item.profiles!.files!) {
            item.image = getImageUrl(file.fileId);
          }  
        }  
        showCaseData = data.data;
      } 
    } 
    catch (e) {
      showcaseLoading(false);
      Get.back();
      log(e.toString());
    }
    finally{
      showcaseLoading(false);
    }
  }

  // 1-4 Get Product Detail
  getShowcaseDetail(casseteeId) async {
    try {
      showcaseDetailLoading(true);
      showCaseDetailImg.clear();
      showCaseDetailsPinned.clear();
      similarItems.clear();
      var response = await ApiRepo.apiGet('${garageProposalOApi}v1.0/cassette/${read('leafId')}/${read('areaId')}/$casseteeId','','1-4_カセットの詳細を取得する #Showcase Detail');
      if(response != null && response['resultCode'] == 0) {
        final data = ShowCaseDetailModel.fromJson(response);
        showCaseDetailDesc = data.data!.profiles!.discription!;
        for(var image in data.data!.profiles!.files!) {
          showCaseDetailImg.add(image.fileId);
          for(var pin in image.pinned!){
            showCaseDetailsPinned.add({
              "id" : pin.itemId,
              "x" : pin.positionX,
              "y" : pin.positionY
            });
          }
        } 
        if(data.data!.profiles!.items!.isEmpty){
          similarItems.clear();
        }
        else{
          for(var item in data.data!.profiles!.items!){
            similarItems.add(
              {
                "id" : item,
                "name" : await getCoordinatingProducts(item),
                "sub" : "",
                "image" : getImageUrl(coordinatingImg[0])
              }
            );
          }
        }
      } 
    } 
    catch (e) {
      showcaseDetailLoading(false);
      // Get.back();   
      log(e.toString());
    }
    finally{
      showcaseDetailLoading(false);
    }
  }

  // 6-2 Get Coordinating Image Name
  getCoordinatingProducts(leafProductId) async {
    try {
      var response = await ApiRepo.apiGet('${garageApi}v1.0/itemInfo/$leafProductId','','6-2_商品情報の詳細取得');
      if(response != null) {
        for(var img in response["data"]["files"]){
          coordinatingImg.add(img['fileboxFileLinkId']);
        }
        return response["data"]["items"]["productName"] ?? "";
      } 
    } 
    catch (e) {
      log(e.toString());
    }
  }


  // Post Assign to folder
  addToFolder(folderId, cassetteId, folderName) async {
    try {
      loadingWidget();
      var response = await ApiRepo.apiPost('${garageProposalOApi}v1.0/cassette/${read('leafId')}/$folderId/relation/$cassetteId', '', 'コレクションにカセットを紐付ける # Assign Folder');
      if(response != null && response["resultCode"] == 0) {
        Get.back();
        Get.back();
        showToastMessage('Product added to $folderName');
      } 
    } catch (e) {
      Get.back();
      showToastMessage(e.toString());
    }
  }
}