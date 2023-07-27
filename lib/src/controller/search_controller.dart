// import 'package:get/get.dart';
// import 'package:nafcassete/src/helpers/repository.dart';
// import 'package:nafcassete/src/model/search_model.dart';
// import '../widgets/show_message.dart';

// class SearchController extends GetxController{
//   List<Searchmodel> searchData = [];
//   var searchLoading = false.obs;

//   getSearchData() async {
//     try {
//       searchLoading(true);
//       var response = await ApiRepo.apiGet('search.json', '');
//       if(response!= null){
//         final result = List<Map<String, dynamic>>.from(response);
//         final data = result.map((e) => Searchmodel.fromJson(e)).toList();
//         searchData = data;
//       }
//     } on Exception catch (e) {
//       showMessage("An Error Occured!", e.toString());
//     } finally {
//       searchLoading(false);
//     }
//   }
// }