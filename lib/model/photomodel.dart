class PhotoModel {
  String imgSrc;
  String PhotoName;

  PhotoModel({required this.imgSrc, required this.PhotoName});

  static PhotoModel fromApi2App(Map<String, dynamic> photoMap) {
    return PhotoModel(
      imgSrc: (photoMap["src"])["portrait"],
      PhotoName: photoMap["photographer"],
    );
  }
}
