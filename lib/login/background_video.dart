import "package:video_player/video_player.dart";

class VideoControllerSingleton {
  static final VideoControllerSingleton _instance =
      VideoControllerSingleton._internal();
  late VideoPlayerController _controller;

  factory VideoControllerSingleton() {
    return _instance;
  }

  VideoControllerSingleton._internal() {
    _controller = VideoPlayerController.asset('assets/pexels_video.mp4');
    _controller.initialize().then((_) {
      _controller.setLooping(true);
      _controller.play();
    });
  }

  VideoPlayerController get controller => _controller;
}
