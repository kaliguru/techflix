
import 'package:get/get.dart';
import 'package:play_lab/data/repo/otp_repo/otp_repo.dart';

  class OtpController extends GetxController implements GetxService{
    OtpRepo repo;
    OtpController({required this.repo});
  }