import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Sermon {
  final String id;
  final String title;
  final DateTime publishedAt;
  final Duration duration;
  final int views;

  Sermon({
    required this.id,
    required this.title,
    required this.publishedAt,
    required this.duration,
    required this.views,
  });
}



class SermonService {
  final YoutubeExplode _yt = YoutubeExplode();

  Future<Sermon> fetchVideo(String videoId) async {
    final video = await _yt.videos.get(videoId);

    return Sermon(
      id: videoId,
      title: video.title,
      publishedAt: video.uploadDate ?? DateTime.now(),
      duration: video.duration ?? Duration.zero,
      views: video.engagement.viewCount,
    );
  }

  Future<List<Sermon>> fetchMultiple(List<String> ids) async {
    final futures = ids.map((id) => fetchVideo(id));
    return Future.wait(futures);
  }

  void dispose() {
    _yt.close();
  }
}