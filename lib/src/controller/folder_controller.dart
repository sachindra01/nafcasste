import 'package:get/get.dart';
import 'package:nafcassete/src/helpers/read_write.dart';
import 'package:nafcassete/src/helpers/repository.dart';
import 'package:nafcassete/src/model/folder_model.dart';
import 'package:nafcassete/src/widgets/custom_toast.dart';

import '../helpers/constant.dart';

class FolderController extends GetxController{
  // List<ShowCaseModel> showCaseData = [];
  var folderLoading = false.obs;
  var foldercreateLoading = false.obs;
  var folderdeleteLoading = false.obs;
  dynamic folderlist ;
  dynamic folderId;
  RxString foldername = ''.obs;


  createFolder(name)async{
    try {
      foldercreateLoading(true);
       var data = {
        "name": name,
      };
     var path = '${garageProposalOApi}v1.0/collection/${read('leafId')}/${read('collectionId')}';
      var response = await ApiRepo.apiPost(path,data,'3-1_コレクションフォルダーを登録する #Folder Register');
      if(response != null && response['resultCode'] == 0) {
         showToastMessage('フォルダが作成されました');
      } 
    } catch (e) {

      showToastMessage(e.toString());
    }finally{
        foldercreateLoading(false);
    }

  }


  getFolderList() async {
    try {
      folderLoading(true);
     var path = '${garageProposalOApi}v1.0/collection/${read('leafId')}/${read('collectionId')}/list';
      var response = await ApiRepo.apiGet(path,'','3-2_コレクションのフォルダーリストの取得 #Folder List');
      if(response != null && response['resultCode'] == 0) {
        final data = FolderModel.fromJson(response);
        folderlist=data.data;
       for (var i = 0; i < folderlist.length; i++) {
        folderId =folderlist[0].id;
        foldername(folderlist[0].name);
       }
        return data;
      } 
    } catch (e) {

      showToastMessage(e.toString());
    }finally{
        folderLoading(false);
    }
  }
  deleteFolder(folderId)async{
    try {
      folderdeleteLoading(true);
     var path = '${garageProposalOApi}v1.0/collection/${read('leafId')}/${read('collectionId')}/$folderId';
      var response = await ApiRepo.apiDelete(path,'3-3_コレクションのフォルダーを削除する #Folder Delete');
      if(response != null && response['resultCode'] == 0) {
         showToastMessage('フォルダが削除されました');
      } 
    } catch (e) {
      showToastMessage(e.toString());
    }finally{
        folderdeleteLoading(false);
    }

  }

}