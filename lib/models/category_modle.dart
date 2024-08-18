class CategoryModle{
    int? id;
    String ? name;
    String ? image;
    CategoryModle(this.id, this.name, this.image);

   CategoryModle. fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}