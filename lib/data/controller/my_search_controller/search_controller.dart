
import 'dart:convert';

import 'package:get/get.dart';
import 'package:play_lab/data/model/search/MySearchResponseModel.dart';
import 'package:play_lab/data/repo/my_search/my_search_repo.dart';

import '../../model/global/response_model/response_model.dart';

class MySearchController extends GetxController{

  MySearchRepo repo;
  MySearchController({required this.repo,this.searchText='',this.subCategoryId=-1,this.categoryId=-1});

  String? nextPageUrl;
  bool isLoading=true;
  List<Data>movieList=[];
  int categoryId=-1;
  int subCategoryId=-1;
  int subCategoryIndex=-1;
  late String searchText;
  String portraitImagePath='';

  bool paginationLoading=false;
  updatePaginationLoading(bool status){
    paginationLoading=status;
    update();
  }

  changeSelectedSubCategoryIndex(int index){
   subCategoryIndex=index;
    update();
  }

  void changeSubCategoryId(int id){
    if(id!=subCategoryId){
      subCategoryId=id;
      fetchInitialSubCategoryData();
      update();
    }
  }

  int page = 0;

  void fetchInitialSubCategoryData() async {
    updateStatus(true);
    page =1; //page+1;
    ResponseModel model =
    await repo.getMovie(page:page,searchText: searchText,categoryId: categoryId,subCategoryId: subCategoryId);

    if(model.statusCode==200)
    {

      MySearchResponseModel searchResponse=MySearchResponseModel.fromJson(jsonDecode(model.responseJson));
      List<Data>?teamMovieList=searchResponse.data?.items?.data;
      nextPageUrl=searchResponse.data?.items?.nextPageUrl;
      portraitImagePath=searchResponse.data?.portraitPath??'';

      if(teamMovieList !=null && !(teamMovieList==[]) )
      {
        //first time we need to clear previous data. but in other condition we can't clear bcz we store paginated data
        if(page==1){
          movieList.clear();
        }
        movieList.addAll(teamMovieList);
        //portraitImagePath=searchResponse.data.items.path.
      }

      updateStatus(false);

    } else
    {
      updateStatus(false);
    }
  }
  void fetchSubCategoryData() async {
    page =page+1; //page+1;
    ResponseModel model =
    await repo.getMovie(page:page,searchText: searchText,categoryId: categoryId,subCategoryId: subCategoryId);

    if(model.statusCode==200)
    {

      MySearchResponseModel searchResponse=MySearchResponseModel.fromJson(jsonDecode(model.responseJson));
      List<Data>?teamMovieList=searchResponse.data?.items?.data;
      nextPageUrl=searchResponse.data?.items?.nextPageUrl;

      if(teamMovieList !=null && !(teamMovieList==[]) )
      {
        movieList.addAll(teamMovieList);

      }

update();

    }
  }



  updateStatus(bool status) {
    isLoading = status;
    update();
  }

  bool hasNext() {
    return nextPageUrl != null ? true : false;
  }

  void clearAllData(){
    page=0;
    isLoading=true;
    nextPageUrl=null;
    subCategoryId=-1;
    categoryId=-1;
    movieList.clear();
  }

  void gotoDetailsPage(int index) {
    //goto movie details page with index number
  }



}