class VideoItem {
  final int id;
  final String title;
  final String description;
  final String videoType;
  final String videoUrl;

  VideoItem({
    required this.id,
    required this.title,
    required this.description,
    required this.videoType,
    required this.videoUrl,
  });

  factory VideoItem.fromJson(Map<String, dynamic> json) {
    return VideoItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      videoType: json['video_type'],
      videoUrl: json['video_url'],
    );
  }
}
