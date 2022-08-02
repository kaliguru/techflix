
import 'dart:convert';

import 'package:get/get.dart';
import 'package:play_lab/data/model/all_movie/AllMovieResponseModel.dart';
import 'package:play_lab/data/repo/all_movies_repo/all_movies_repo.dart';

import '../../model/global/response_model/response_model.dart';

class AllMoviesController extends GetxController {

  AllMoviesRepo repo;
  AllMoviesController({required this.repo});

  String? nextPageUrl;
  bool isLoading=true;
  List<Data>movieList=[];
  String portraitImagePath='';

  bool paginationLoading=false;
  updatePaginationLoading(bool status){
    paginationLoading=status;
    update();
  }


  int page = 0;

  void fetchInitialMovieList() async {
    updateStatus(true);
    page =1; //page+1;
    ResponseModel model =
    await repo.getMovie(page);

    if(model.statusCode==200)
    {

      AllMovieResponseModel allMovieResponseModel=AllMovieResponseModel.fromJson(jsonDecode(model.responseJson));
      List<Data>?tempMovieList=allMovieResponseModel.mainData?.movies?.data;
      portraitImagePath=allMovieResponseModel.mainData?.portraitPath??'';
      nextPageUrl=allMovieResponseModel.mainData?.movies?.nextPageUrl;

      if(tempMovieList !=null && !(tempMovieList==[]) )
      {
        //first time we need to clear previous data. but in other condition we can't clear bcz we store paginated data

        movieList.clear();
        movieList.addAll(tempMovieList);
        //portraitImagePath=searchResponse.data.items.path.
      }
      updateStatus(false);

    } else
    {
      updateStatus(false);
    }
  }
  void fetchNewMovieList() async {
    page =page+1; //page+1;
    ResponseModel model =
    await repo.getMovie(page);

    if(model.statusCode==200)
    {

      AllMovieResponseModel allMovieResponseModel=AllMovieResponseModel.fromJson(jsonDecode(model.responseJson));
      List<Data>?tempMovieList=allMovieResponseModel.mainData?.movies?.data;
      nextPageUrl=allMovieResponseModel.mainData?.movies?.nextPageUrl;
      if(tempMovieList !=null && !(tempMovieList==[]) )
      {
        movieList.addAll(tempMovieList);
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
    movieList.clear();
  }

  void gotoDetailsPage(int index) {
    //goto movie details page with index number
  }


}