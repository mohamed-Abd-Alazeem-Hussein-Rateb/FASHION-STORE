class Contact {
  final int id;
  final int type;
  final String value;
  final String image;

  Contact({required this.id, required this.type, required this.value, required this.image});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      type: json['type'],
      value: json['value'],
      image: json['image'],
    );
  }
}

class ContactsResponse {
  final List<Contact> contacts;

  ContactsResponse({required this.contacts});

  factory ContactsResponse.fromJson(Map<String, dynamic> json) {
    // الوصول إلى القائمة الصحيحة من البيانات
    var list = json['data']['data'] as List;
    List<Contact> contactsList = [];
    
    // استخدام حلقة for لإضافة العناصر إلى القائمة
    for (var item in list) {
      contactsList.add(Contact.fromJson(item));
    }
    
    // إعادة كائن ContactsResponse مع قائمة من العناصر المحولة
    return ContactsResponse(contacts: contactsList);
  }
}





