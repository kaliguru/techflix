
import 'package:get/get.dart';
import 'package:play_lab/data/repo/episode_repo/episode_repo.dart';

class EpisodeController extends GetxController implements GetxService{
  EpisodeRepo repo;
  EpisodeController({required this.repo});
}