import 'dart:developer';
import 'package:get/get.dart';
import 'package:nafcassete/src/bottom_nav.dart';
import 'package:nafcassete/src/helpers/constant.dart';
import 'package:nafcassete/src/helpers/read_write.dart';
import 'package:nafcassete/src/helpers/repository.dart';
import 'package:nafcassete/src/widgets/custom_toast.dart';
import 'package:nafcassete/src/widgets/loading_widget.dart';

class AuthController extends GetxController{

  //5-1 
  login1(name, password) async {
    try {
      loadingWidget();
      var data = {
        "nickName": name,
        "password": password
      };
      var response = await ApiRepo.apiPost('${garageApi}v1.0/login', data, '5-1_ログイン');
      if(response != null) {
        write('tokenId',response['data']['token']);
        write('garageId',response['data']['garages'][0]['garageId']);
        login2(response['data']['garages'][0]['garageId']);
      } 
    } catch (e) {
      Get.back();
      log(e.toString());
    }
  }

  login2(garageID) async {
    try {
      // loadingWidget();
      var response = await ApiRepo.apiGet('${garageApi}v1.0/service/$garageID','', '5-2_Leaf取得');
      if(response != null ) {
        for(var item in response['data']['leafs']) {
          if(item['systemKey'] == "garage_item_proposal"){
            write('leafId',item['leafId']);
            login3(item['leafId']); 
          }
        }      
      }
    } catch (e) {
      Get.back();   // pop custom loading
      log(e.toString());
    }
  }

  login3(leafID) async {
    try {
      var response = await ApiRepo.apiGet('${garageProposalOApi}v1.0/area/$leafID','', '5-3_エリアの取得');
      if(response != null && response['resultCode'] == 0) {
        // Get.back(); 
        write('areaId',response['data']['areaId']);
        write('collectionId',response['data']['collectionId']);
      } 
    } catch (e) {
      Get.back();
      log(e.toString());
    } finally {
      Get.back();   // pop custom loading
      Get.offAll(()=>const BottomNavbar(index: 2),transition: Transition.cupertinoDialog, duration: const Duration(seconds: 1));
      showToastMessage('Login Successful');
    }
  }

}

