
import 'dart:convert';

import 'package:get/get.dart';
import 'package:play_lab/data/model/all_episode/AllEpisodeResponseModel.dart';
import 'package:play_lab/data/repo/all_episode_repo/all_episode_repo.dart';

import '../../model/global/response_model/response_model.dart';

class AllEpisodeController extends GetxController{

  AllEpisodeRepo repo;

  AllEpisodeController({required this.repo});

  String? nextPageUrl;
  bool isLoading=true;
  List<Data>episodeList=[];
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
    await repo.getEpisode(page);

    if(model.statusCode==200)
    {

      AllEpisodeResponseModel allEpisodeResponse= AllEpisodeResponseModel.fromJson(jsonDecode(model.responseJson));
      List<Data>?tempEpisodeList=allEpisodeResponse.data?.episodes?.data;
      portraitImagePath=allEpisodeResponse.data?.portraitPath??'';
      nextPageUrl=allEpisodeResponse.data?.episodes?.nextPageUrl??'';

      if(tempEpisodeList !=null && !(tempEpisodeList==[]) )
      {
        //first time we need to clear previous data. but in other condition we can't clear bcz we store paginated data

        episodeList.clear();
        episodeList.addAll(tempEpisodeList);
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
    await repo.getEpisode(page);

    if(model.statusCode==200)
    {

     AllEpisodeResponseModel allMovieResponseModel=AllEpisodeResponseModel.fromJson(jsonDecode(model.responseJson));
      List<Data>?tempMovieList=allMovieResponseModel.data?.episodes?.data;
      nextPageUrl=allMovieResponseModel.data?.episodes?.nextPageUrl;
      if(tempMovieList !=null && !(tempMovieList==[]) )
      {
        episodeList.addAll(tempMovieList);
      }
      updatePaginationLoading(false);
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
    episodeList.clear();
  }

  void gotoDetailsPage(int index) {
    //goto movie details page with index number
  }

}