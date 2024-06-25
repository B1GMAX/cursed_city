import 'package:cursed_city/presentation/game/game_screen.dart';
import 'package:cursed_city/repository/preferences/preferences.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class HomeController extends GetxController {
  late AudioPlayer _player;
  bool isPlaying = false;

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

  void startNewGame() async {
   await (await Preferences.instance.pref).clear();
    Get.to(
      () => const GameScreen(),
    );
  }

  void playPause() {
    if (_player.playing) {
      _player.pause();
      isPlaying = !isPlaying;
    } else {
      _player.play();
      isPlaying = !isPlaying;
    }
    update();
  }
}
