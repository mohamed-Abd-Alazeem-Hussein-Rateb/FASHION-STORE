 class BannersModle {
  String? image;
  int? id; // تعديل نوع المتغير من String إلى int

  BannersModle({this.image, this.id});

  BannersModle.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    id = json['id'];
  }
}
