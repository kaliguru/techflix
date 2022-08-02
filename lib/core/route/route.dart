
import 'package:get/get.dart';
import 'package:play_lab/view/screens/about/privacy_screen.dart';
import 'package:play_lab/view/screens/account/chagne_password/change_password.dart';
import 'package:play_lab/view/screens/account/payment_log_screen/transaction_log_screen.dart';
import 'package:play_lab/view/screens/account/profile/profile_complete_screen.dart';
import 'package:play_lab/view/screens/account/profile/profile_screen.dart';
import 'package:play_lab/view/screens/all_episode/all_episode_screen.dart';
import 'package:play_lab/view/screens/all_free_zone/free_zone_screen.dart';
import 'package:play_lab/view/screens/all_live_tv/live_tv.dart';
import 'package:play_lab/view/screens/auth/forget_password/forget_password.dart';
import 'package:play_lab/view/screens/auth/forget_password/reset_pass_screen/reset_pass_screen.dart';
import 'package:play_lab/view/screens/auth/forget_password/verify_forget_password_code_screen/verify_forget_pass_code.dart';
import 'package:play_lab/view/screens/my_search/search_screen.dart';
import  'package:play_lab/view/screens/onboard/onboard_screen.dart';
import 'package:play_lab/view/screens/sub_category/sub_category_screen.dart';
import 'package:play_lab/view/screens/subscribe_plan/add_deposit_screen/add_deposit_screen.dart';
import '../../view/screens/auth/email_verification_page/email_verification_screen.dart';
import '../../view/screens/auth/login/login.dart';
import '../../view/screens/auth/registration/registration_screen.dart';
import '../../view/screens/auth/sms_verification_page/sms_verification_screen.dart';
import '../../view/screens/bottom_nav_pages/all_movies/AllMovies_screen.dart';
import '../../view/screens/bottom_nav_pages/home/home_screen.dart';
import '../../view/screens/live_tv_details/live_tv_details_screen.dart';
import '../../view/screens/movie_details/movie_details.dart';
import '../../view/screens/splash/splash_screen.dart';
import '../../view/screens/subscribe_plan/subscribe_plan_screen.dart';
import '../../view/screens/subscribe_plan/web_view/deposit_payment_webview.dart';
import '../../view/screens/watch_history/my_watch_history.dart';
import '../../view/screens/wish_list/wish_list_screen.dart';


class RouteHelper{

              static const String splashScreen='/splash-screen';


              static const String loginScreen='/login-screen';
              static const String onboardScreen='/onboard-screen';
              static const String registrationScreen='/signup-screen';
              static const String emailVerificationScreen='/verify-email-screen';
              static const String smsVerificationScreen='/verify-sms-screen';
              static const String forgetPasswordScreen='/forget-password-screen';
              static const String verifyPassCodeScreen='/verify-pass-code-screen';
              static const String resetPasswordScreen='/reset-pass-screen';



              static const String subCategoryScreen='/sub-category-screen';


              static const String allMovieScreen='/all-movie-screen';
              static const String allEpisodeScreen='/all-episode-screen';
              static const String homeScreen='/home-screen';
              static const String wishListScreen='/wishlist-screen';


              static const String allLiveTVScreen='/all-live-tv-screen';
              static const String liveTvDetailsScreen='/live-tv-details-screen';


              static const String allFreeZoneScreen='/all-free-zone-screen';


              static const String customWebviewScreen='/custom-wv-screen';


              static const String profileScreen='/profile-screen';
              static const String profileComplete='/profile-complete-screen';
              static const String changePasswordScreen='/change-password-screen';
              static const String subscribeScreen='/subscribe-screen';
              static const String depositScreen='/deposit-screen';
              static const String myWatchHistoryScreen='/history-screen';
              static const String paymentHistoryScreen='/payment-screen';
              static const String privacyScreen='/privacy-screen';


              static const String movieDetailsScreen='/movie-details-screen';
              static const String searchScreen='/movie-search-screen';


  static List<GetPage> routes = [

          GetPage(name: splashScreen, page: () =>  const SplashScreen()),
          GetPage(name: onboardScreen, page: () =>  const OnBoardingScreen()),
          GetPage(name: allMovieScreen, page: () =>  const AllMovieScreen()),
          GetPage(name: allEpisodeScreen, page: () =>  const AllEpisodeScreen()),



          GetPage(name: customWebviewScreen, page: () =>   CustomWebViewScreen(redirectUrl: Get.arguments)),
          GetPage(name: privacyScreen, page: () =>   const PrivacyScreen()),
          GetPage(name: wishListScreen, page: () =>   const WishListScreen()),
          GetPage(name: myWatchHistoryScreen, page: () =>   const MyWatchHistoryScreen()),
          GetPage(name: subscribeScreen, page: () =>  const SubscribePlanScreen()),
          GetPage(name: profileScreen, page: () =>  const ProfileScreen()),
          GetPage(name: profileComplete, page: () =>  const ProfileCompleteScreen()),
          GetPage(name: changePasswordScreen, page: () =>  const ChangePasswordScreen()),
          GetPage(name: paymentHistoryScreen, page: () =>  const PaymentLogsScreen()),



           GetPage(name: loginScreen, page: () =>   const LoginScreen()),
           GetPage(name: registrationScreen, page: () =>   const RegistrationScreen()),
           GetPage(name: emailVerificationScreen, page: () =>    EmailVerificationScreen(needSmsVerification: Get.arguments,)),
           GetPage(name: smsVerificationScreen, page: () =>   const SmsVerificationScreen()),
           GetPage(name: forgetPasswordScreen, page: () =>   const ForgetPasswordScreen()),
           GetPage(name: verifyPassCodeScreen, page: () =>   const VerifyForgetPassScreen()),
           GetPage(name: resetPasswordScreen, page: () =>   const ResetPasswordScreen()),



           GetPage(name: homeScreen, page: () =>   const HomeScreen()),
           GetPage(name: movieDetailsScreen, page: () =>  MovieDetailsScreen(itemId: Get.arguments[0],episodeId: Get.arguments[1],)),
           GetPage(name: searchScreen, page: () =>    SearchScreen(searchText: Get.arguments,)),



           GetPage(name: allLiveTVScreen, page: () =>   const AllLiveTvScreen()),
           GetPage(name: liveTvDetailsScreen, page: () =>   const LiveTvDetailsScreen()),



           GetPage(name: subCategoryScreen, page: () =>    SubCategoryScreen(subCategoryId: Get.arguments,)),



          GetPage(name: depositScreen, page: () =>   const AddDepositScreen()),
          GetPage(name: allFreeZoneScreen, page: () =>   const AllFreeZoneScreen()),




  ];








}