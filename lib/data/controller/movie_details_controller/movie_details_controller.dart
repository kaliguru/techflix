
import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/helper/shared_pref_helper.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/model/play_video_response_model/PlayVideoResponseModel.dart';
import 'package:play_lab/data/model/video_details/video_details_response_model/VideoDetailsResponseModel.dart';
import 'package:play_lab/data/model/wishlist_model/AddInWishlistResponseModel.dart';
import 'package:play_lab/data/repo/movie_details_repo/movie_details_repo.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../../../core/route/route.dart';

class MovieDetailsController extends GetxController {

  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;


  void initializePlayer(String s)async{

      videoPlayerController=VideoPlayerController.network(s);
      await videoPlayerController.initialize();
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: 4 / 2,
        autoPlay: true,
       /* showControlsOnInitialize: true,
        showControls: true,*/
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.blue,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.lightGreen,
        ),
        autoInitialize: true,
      );

    videoUrl=s;
    playVideoLoading=false;
    update();
  }

  String videoUrl='';

  clearData(bool isBack){
    try{
      playVideoLoading=true;
      videoDetailsLoading=true;
      videoPlayerController.dispose();
      chewieController.dispose();
    }finally{
      if(isBack){
        Get.back();
      }
    }
  }

 bool isDescriptionShow=true;
 bool isTeamShow=false;
 late int itemId;
 late int episodeId;

 bool playVideoLoading=true;
 bool videoDetailsLoading=true;

 bool isEpisode=false;
 String portraitImagePath='';
 String episodePath='';

 List<RelatedItems>relatedItemsList=[];
 List<Episodes>episodeList=[];

 VideoDetailsResponseModel movieDetails=VideoDetailsResponseModel();

  MovieDetailsRepo movieDetailsRepo;
  MovieDetailsController({required this.movieDetailsRepo,required this.itemId,this.episodeId=-1});

  Future<dynamic>getVideoDetails(int itemId,int episodeId)async{
        this.itemId=itemId;
        this.episodeId=episodeId;

         loadVideoDetails();
         if(isAuthorized()){
           checkWishlist();
         }

         //loadVideoUrl();
  }

  Future<dynamic>loadVideoDetails()async{

    updateVideoDetailsLoadingStatus(true);

     ResponseModel model=await movieDetailsRepo.getWatchVideoData(itemId,episodeId: episodeId==-1?-1:episodeId);

     if(model.statusCode==200){
       VideoDetailsResponseModel responseModel=VideoDetailsResponseModel.fromJson(jsonDecode(model.responseJson));
       if(responseModel.status?.toLowerCase()=='success'.toLowerCase() && responseModel.data?.item !=null){
         movieDetails =responseModel;
         playerImage=movieDetails.data?.item?.image?.landscape??'';
         playerAssetPath=movieDetails.data?.landscapePath??'';
         if(responseModel.data?.relatedItems !=null && !(responseModel.data!.relatedItems==[]) ){
           relatedItemsList.clear();
           relatedItemsList.addAll(responseModel.data!.relatedItems!);
           portraitImagePath=responseModel.data?.portraitPath??'';
           episodePath=responseModel.data?.episodePath??'';
         }
         if(responseModel.data?.episodes !=null && responseModel.data!.episodes!.isNotEmpty){
           episodeList.clear();
           episodeList.addAll(responseModel.data!.episodes!);
           if(episodeId==-1){
             episodeId=episodeList[0].id??-1;
             loadVideoUrl();
           }else{
             loadVideoUrl();
           }
         }else{
           loadVideoUrl();
         }
         updateVideoDetailsLoadingStatus(false);
       }else{
         if(responseModel.remark=='unauthorized'){
           CustomSnackbar.showCustomSnackbar(errorList: ['Unauthorized User , Pls Login First'], msg: [], isError: true);
         }else if(responseModel.remark=='purchase_plan'){
           CustomSnackbar.showCustomSnackbar(errorList: ['Pls Purchase a Plan'], msg: [], isError: true);
         }else{
           CustomSnackbar.showCustomSnackbar(errorList: ['Something Went Wrong'], msg: [], isError: true);
         }
         lockVideo=true;
         playVideoLoading=false;
         updateVideoDetailsLoadingStatus(false);
       }

     } else{
       lockVideo=true;
       playVideoLoading=false;
       updateVideoDetailsLoadingStatus(false);
       CustomSnackbar.showCustomSnackbar(errorList: [model.message], msg: [], isError: true);
     }
  }

  updateVideoDetailsLoadingStatus(bool status){
    videoDetailsLoading=status;
    update();
  }

  bool isFavourite=false;
  bool hideWishlist=true;
  void checkWishlist()async{
    wishListLoading=true;
    hideWishlist=true;
    update();
    bool inWishList=await movieDetailsRepo.checkWishlist(itemId,episodeId: episodeId);
    isFavourite=inWishList;
    wishListLoading=false;
    hideWishlist=false;
    update();
  }

String playerImage='';
  String playerAssetPath='';
bool lockVideo=false;
  Future<dynamic>loadVideoUrl()async{

    playVideoLoading=true;
    update();
    ResponseModel model=await movieDetailsRepo.getPlayVideoData(itemId,episodeId: episodeId);

    if(model.statusCode==200){
      PlayVideoResponseModel responseModel=PlayVideoResponseModel.fromJson(jsonDecode(model.responseJson));
      if(responseModel.data !=null && responseModel.data?.video !=null ){
          initializePlayer(responseModel.data!.video??'');
      }else{
        lockVideo=true;
        CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message?.error??'Something Went Wrong'], msg: [], isError: true);
        playVideoLoading=false;
        update();
      }
    }else{
      CustomSnackbar.showCustomSnackbar(errorList: [model.message], msg: [], isError: true);
      playVideoLoading=false;
      lockVideo=true;
      update();
    }

  }

  Future<bool> shareVideo(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    await Share.share("https://play.google.com/store/apps/details?id=${packageInfo.packageName}",subject: 'Exclusive movie in Play lab');
    return true;
  }

  void changeIsTeamVisibility(bool isTeamShow){
    this.isTeamShow=isTeamShow;
    update();
  }

  bool wishListLoading=false;

  void addInWishList() async{
    if(isFavourite){
      CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.alreadyInWishlist], msg: [], isError: true);
      return;
    }
    updateWishListLoading(true);
    ResponseModel model=await movieDetailsRepo.addInWishList(itemId,episodeId: episodeId);
    if(model.statusCode==200){
      AddInWishlistResponseModel m=AddInWishlistResponseModel.fromJson(jsonDecode(model.responseJson));
      if(m.status=='success'){
        isFavourite=true;
        update();
        CustomSnackbar.showCustomSnackbar(errorList: [], msg: [m.message?.success??''], isError: false);
      }else{
        CustomSnackbar.showCustomSnackbar(errorList: [m.message?.error??'Fail to Add in Wishlist'], msg: [], isError: true);
      }
     updateWishListLoading(false);
    }else{
      CustomSnackbar.showCustomSnackbar(errorList: [model.message], msg: [], isError: true);
      updateWishListLoading(false);
    }
  }
  updateWishListLoading(bool status){
    wishListLoading=status;
    update();
  }


  void gotoNextPage(int id,int episodeId){
    clearData(false);
    Get.offAndToNamed(
        RouteHelper.movieDetailsScreen,
        arguments: [
         id,
          episodeId
        ]);
  }

  bool isAuthorized(){
    String token=movieDetailsRepo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey)??'';
   return token.isEmpty?false:true;
  }

}