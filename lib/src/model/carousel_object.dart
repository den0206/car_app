class CarouselObject {
  String id;
  String author;

  String downloaUrl;

  CarouselObject.fromJson(Map<String, dynamic> json)
      : id = json[CarouselObjectKey.id] ?? "",
        author = json[CarouselObjectKey.author] ?? "",
        downloaUrl = json[CarouselObjectKey.downloaUrl] ?? "";
}

class CarouselObjectKey {
  static final id = "id";
  static final author = "author";
  static final downloaUrl = "download_url";
}
