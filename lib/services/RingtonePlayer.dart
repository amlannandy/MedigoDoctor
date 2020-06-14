import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class RingtonePlayer {
  
  static const filePath = "ringing.mp3";
  static AudioCache player = AudioCache();
  static AudioPlayer newPlayer;

  static void playSound() async {
    newPlayer = await player.loop(filePath);
  }

  static void stopSound() {
    newPlayer.stop();
  }
}
