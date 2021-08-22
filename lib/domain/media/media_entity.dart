class Media {
  final String id;
  final String thumbnailUrl;

  Media({
    required this.id,
    required this.thumbnailUrl,
  });

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
        id: map['id'],
        thumbnailUrl: map['thumbnail_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'thumbnail_url': thumbnailUrl,
    };
  }
}
