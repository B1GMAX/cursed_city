import 'package:cursed_city/models/task_model.dart';
import 'package:cursed_city/presentation/game/game_screen.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class HomeController extends GetxController {
  late AudioPlayer _player;

  final _playlist = ConcatenatingAudioSource(children: [
    AudioSource.asset(
      'assets/audio/music.mp3',
      tag: const MediaItem(
        id: '1',
        album: "Album name",
        title: "Song name",
      ),
    ),
  ]);

  @override
  void onInit() async {
    super.onInit();
    _player = AudioPlayer();


    _player.setLoopMode(LoopMode.all);

    print('_player.loopMode - ${_player.loopMode}');

    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      Get.snackbar('Something went wrong!',
          'Something went wrong during loading music!');
    });
    try {
      await _player.setAudioSource(_playlist);
      _player.play();
    } catch (e) {
      Get.snackbar('Something went wrong!',
          'Something went wrong during loading music!');
    }
  }

  void goToGameScreen(
    int? balanceFormBd,
    int? slotStageFromBd,
    List<TaskModel>? tasksFromBd,
  ) {
    Get.to(
      () => GameScreen(
        balanceFormBd: balanceFormBd,
        slotStageFromBd: slotStageFromBd,
        tasksFromBd: tasksFromBd,
      ),
    );
  }

  void playPause() {
    if (_player.playing) {
      _player.pause();
    } else {
      _player.play();
    }
  }
}
