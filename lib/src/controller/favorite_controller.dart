import 'package:get/get.dart';
import 'package:nafcassete/src/helpers/constant.dart';
import 'package:nafcassete/src/helpers/read_write.dart';
import 'package:nafcassete/src/helpers/repository.dart';
import 'package:nafcassete/src/model/showcase_model.dart';
import 'package:nafcassete/src/widgets/custom_toast.dart';

class FavoriteController extends GetxController{
  // List<ShowCaseModel> showCaseData = [];
  var isfavoriteLoading = false.obs;
  dynamic favoriteData;

  getShowfavoriteData(folderId) async {
    try {
      isfavoriteLoading(true);
     var path = '${garageProposalOApi}v1.0/cassette/${read('leafId')}/$folderId/list';
      var response = await ApiRepo.apiGet(path,'','コレクションのカセット一覧を取得する #product folder list');
      if(response != null && response['resultCode'] == 0) {
        final data = ShowCaseModel.fromJson(response);
          for(var item in data.data!) {
            for(var file in item.profiles!.files!) {
              item.image = getImageUrl(file.fileId);
            }  
          }  
         
        favoriteData=data;
        return data;
      } 
    } catch (e) {
      showToastMessage(e.toString());
    }finally{
       isfavoriteLoading(false);
    }
  }
}