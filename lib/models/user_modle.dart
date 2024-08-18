class UserModle{
  String? name;
  String ?email;
  String? phone;
  String? image;
  String? tokenn;

  UserModle({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.tokenn,
  });

  factory UserModle.fromJson(Map<String, dynamic> data) {
    return UserModle(
      name: data['name'],
      email: data['email'], 
      phone: data['phone'],
      image: data['image'],
      tokenn: data['token'],
    );
  } 


// زياده علي الكود
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'token': tokenn,
    };
    }
}