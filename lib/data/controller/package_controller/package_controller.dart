
import 'package:get/get.dart';
import 'package:play_lab/data/repo/package_repo/package_repo.dart';

class PackageController extends GetxController implements GetxService{
  PackageRepo packageRepo;
  PackageController({required this.packageRepo});
}