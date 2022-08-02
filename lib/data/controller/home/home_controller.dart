
 import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/model/home/enum/enum.dart';
import 'package:play_lab/data/model/home/featured_movie/FeaturedMovieResponseModel.dart';
import 'package:play_lab/data/model/home/latest_series/LateastSeriesResponseModel.dart';
import 'package:play_lab/data/model/home/recently_added/RecentlyAddedResponseModel.dart';
import 'package:play_lab/data/model/home/single_banner/SingleBannerResponseModel.dart';
import 'package:play_lab/data/model/home/slider/SliderModel.dart';
import 'package:play_lab/data/model/home/trailer_movie/TrailerMovieResponseModel.dart';
import 'package:play_lab/data/model/live_tv/LiveTvResponseModel.dart';
import 'package:play_lab/data/repo/home_repo/home_repo.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';

import '../../model/home/free_zone/FreeZoneResponseModel.dart' as free_zone;

class HomeController extends GetxController {

  HomeRepo homeRepo;
  HomeController({required this.homeRepo});



 TextEditingController searchController=TextEditingController();

 //slider image
  String sliderImagePath='';
  List<Sliders>sliderList=[
  ];

  //live tv
  List<MainTelevisionModel>televisionList=[];
  String televisionImagePath='';

  //recently added
  List<Recent>recentlyAddedList=[];
  String recentlyAddedImagePath='';

  //latest series
  List<Latest>latestSeriesList=[];
  String latestSeriesImagePath='';

  //single banner
 List<Single> singleBannerList=[];
 String singleBannerImagePath='';

 //trailer movie
  List<Trailer>trailerMovieList=[];
  String trailerImagePath='';

  //free zone movie
  List<free_zone.Data>freeZoneList=[];
  String freeZoneImagePath='';

  //featured movie list
  List<Featured>featuredMovieList=[];
  String featuredMovieImagePath='';

 void searchData(String value){

 }

 bool featuredMovieLoading=true;
 bool freeZoneMovieLoading=true;
 bool latestSeriesMovieLoading=true;
 bool liveTvLoading=true;
 bool recentMovieLoading=true;
 bool singleBannerImageLoading=true;
 bool trailerMovieLoading=true;
 bool sliderLoading=true;




 Future<void>getAllData()async{




         getSlider();
         getLiveTv();
         getRecentMovie();
         getLatestSeriesMovie();
         getSingleBanner();
         getTrailerMovie();
         getFreeZoneMovie();
         getFeaturedMovie();


 }

 void getFeaturedMovie()async{

   updateLoadingStatus(LoadingEnum.featureMovieLoading, true);
   ResponseModel model=await homeRepo.getFeaturedMovie();
   if(model.statusCode==200){
     FeaturedMovieResponseModel featuredMovieModel= FeaturedMovieResponseModel.fromJson(jsonDecode(model.responseJson));
     if(featuredMovieModel.data!=null && featuredMovieModel.data?.featured !=null && featuredMovieModel.data!.featured!.isNotEmpty){
       featuredMovieList.clear();
       featuredMovieList.addAll(featuredMovieModel.data!.featured!);
       featuredMovieImagePath=featuredMovieModel.data?.portraitPath??'';
     }
     updateLoadingStatus(LoadingEnum.featureMovieLoading,false);
   }else{
     updateLoadingStatus(LoadingEnum.featureMovieLoading, false);
   }
 }

 void getFreeZoneMovie()async{
   updateLoadingStatus(LoadingEnum.freeZoneMovieLoading, true);
   ResponseModel model=await homeRepo.getFreeZoneMovie(1);
   if(model.statusCode==200){
     free_zone.FreeZoneResponseModel freeZoneModel= free_zone.FreeZoneResponseModel.fromJson(jsonDecode(model.responseJson));
      if(freeZoneModel.data!=null && freeZoneModel.data?.freeZone?.data !=null && freeZoneModel.data!.freeZone!.data!.isNotEmpty){
        freeZoneList.clear();
        freeZoneList.addAll(freeZoneModel.data!.freeZone!.data!);
        freeZoneImagePath=freeZoneModel.data?.portraitPath??'';
      }
      updateLoadingStatus(LoadingEnum.freeZoneMovieLoading,false);
   }else{
      updateLoadingStatus(LoadingEnum.freeZoneMovieLoading, false);
   }
 }

 void getLatestSeriesMovie()async{
   updateLoadingStatus(LoadingEnum.latestSeriesMovieLoading, true);
   ResponseModel model=await homeRepo.getLatestSeries();
   if(model.statusCode==200){
       LatestSeriesResponseModel latestSeries=LatestSeriesResponseModel.fromJson(jsonDecode(model.responseJson));

       if(latestSeries.data!=null && latestSeries.data?.latest !=null && latestSeries.data!.latest!.isNotEmpty){
         latestSeriesList.clear();
         latestSeriesList.addAll(latestSeries.data!.latest!);
         latestSeriesImagePath=latestSeries.data?.landscapePath??'';
       }

       updateLoadingStatus(LoadingEnum.latestSeriesMovieLoading, false);

   }else{
     CustomSnackbar.showCustomSnackbar(errorList: [model.message], msg: [], isError: false);
     updateLoadingStatus(LoadingEnum.latestSeriesMovieLoading, false);
   }

 }

 void getLiveTv()async{

   updateLoadingStatus(LoadingEnum.liveTvLoading, true);

   ResponseModel model=await homeRepo.getLiveTv();
   if(model.statusCode==200){
      LiveTvResponseModel televisionModel=LiveTvResponseModel.fromJson(jsonDecode(model.responseJson));
      if(televisionModel.data!=null) {
        if(televisionModel.data?.televisions?.data!=null && televisionModel.data!.televisions!.data!.isNotEmpty){
          televisionList.clear();
          televisionList.addAll(televisionModel.data!.televisions!.data!);
          televisionImagePath=televisionModel.data?.imagePath??'';
        }
        updateLoadingStatus(LoadingEnum.liveTvLoading, false);
      }
   }
   else{
     updateLoadingStatus(LoadingEnum.liveTvLoading, false);
   }
 }

 void getRecentMovie()async{
   updateLoadingStatus(LoadingEnum.recentMovieLoading, true);
   ResponseModel model=await homeRepo.getRecentMovie();
   if(model.statusCode==200){
       RecentlyAddedResponseModel recentModel=RecentlyAddedResponseModel.fromJson(jsonDecode(model.responseJson));
       if(recentModel.data?.recent!=null && recentModel.data!.recent!.isNotEmpty){
         recentlyAddedList.clear();
         recentlyAddedList.addAll(recentModel.data!.recent!);
         recentlyAddedImagePath=recentModel.data?.portraitPath??'';
       }
       updateLoadingStatus(LoadingEnum.recentMovieLoading, false);
   }else{
       CustomSnackbar.showCustomSnackbar(errorList: [(model.message)], msg: [], isError: true);
       updateLoadingStatus(LoadingEnum.recentMovieLoading, false);
   }
 }

 void getSingleBanner()async{
  updateLoadingStatus(LoadingEnum.singleBannerImageLoading, true);
   ResponseModel model=await homeRepo.getSingleBannerImage();
   if(model.statusCode==200){
     SingleBannerResponseModel singleBanner=SingleBannerResponseModel.fromJson(jsonDecode(model.responseJson));
     if(singleBanner.data!=null && singleBanner.data?.single!=null){
       singleBannerList=(singleBanner.data?.single)!;
       singleBannerImagePath=singleBanner.data?.landscapePath??'';
     }
     updateLoadingStatus(LoadingEnum.singleBannerImageLoading, false);
   }else{
     CustomSnackbar.showCustomSnackbar(errorList: [model.message], msg: [], isError:true);
     updateLoadingStatus(LoadingEnum.singleBannerImageLoading, false);
   }
 }

 void getTrailerMovie()async{

  updateLoadingStatus(LoadingEnum.trailerMovieLoading, true);
   ResponseModel model=await homeRepo.getTrailerMovie();
   if(model.statusCode==200){

      TrailerMovieResponseModel trailerModel=TrailerMovieResponseModel.fromJson(jsonDecode(model.responseJson));
      if(trailerModel.data?.trailer !=null && trailerModel.data!.trailer!.isNotEmpty ){
        trailerMovieList.clear();
        trailerMovieList.addAll(trailerModel.data!.trailer!);
        trailerImagePath=trailerModel.data?.portraitPath??'';
      }
      updateLoadingStatus(LoadingEnum.trailerMovieLoading, false);
   }else{

     CustomSnackbar.showCustomSnackbar(errorList: [model.message], msg: [], isError: true);
     updateLoadingStatus(LoadingEnum.trailerMovieLoading, false);

   }
 }

 void getSlider()async{

  updateLoadingStatus(LoadingEnum.sliderLoading, true);
   update();
   ResponseModel model=await homeRepo.getSlider();

   if(model.statusCode==200){
       SliderResponseModel sliderModel=SliderResponseModel.fromJson(jsonDecode(model.responseJson));
       if(sliderModel.data!=null) {
         if(sliderModel.data?.sliders!=null && sliderModel.data!.sliders!.isNotEmpty){
           sliderList.clear();
           sliderList.addAll(sliderModel.data!.sliders!);
           sliderImagePath=sliderModel.data?.path??'';
         }
         updateLoadingStatus(LoadingEnum.sliderLoading, false);
       }
   }else{
    updateLoadingStatus(LoadingEnum.sliderLoading, false);
   }

 }


 void updateLoadingStatus(LoadingEnum loadingEnum,bool status){


     if(loadingEnum==LoadingEnum.featureMovieLoading){
       featuredMovieLoading=status;
       update();
     }

     else if(loadingEnum==LoadingEnum.freeZoneMovieLoading){
       freeZoneMovieLoading=status;
       update();
     }

     else if(loadingEnum==LoadingEnum.latestSeriesMovieLoading){
       latestSeriesMovieLoading=status;
       update();
     }

     else if(loadingEnum==LoadingEnum.liveTvLoading){
       liveTvLoading=status;
       update();
     }

     else if(loadingEnum==LoadingEnum.recentMovieLoading){
       recentMovieLoading=status;
       update();
     }

     else if(loadingEnum==LoadingEnum.singleBannerImageLoading){
       singleBannerImageLoading=status;
       update();
     }

     else if(loadingEnum==LoadingEnum.trailerMovieLoading){
       trailerMovieLoading=status;
       update();
     }

     else if(loadingEnum==LoadingEnum.sliderLoading){
       sliderLoading=status;
       update();
     }

 }


}