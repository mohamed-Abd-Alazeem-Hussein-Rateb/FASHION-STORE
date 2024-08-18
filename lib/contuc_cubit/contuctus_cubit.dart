import 'package:flutter_application_1/contuc_cubit/contuctus_state.dart';
import 'package:flutter_application_1/models/contuctus_modle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContuctusCubit extends Cubit<ContuctusState> {
  ContuctusCubit() : super(ContactInitial());
    
     void FetshContactUs() async {
  try {
    emit(ContactLoading());
    final response = await http.get(Uri.parse('https://student.valuxapps.com/api/contacts'));
       var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // print('Complete Data: $data'); // طباعة البيانات لفحصها
      // تأكد من أن البيانات يتم تحليلها بشكل صحيح هنا
      final contactsResponse = ContactsResponse.fromJson(data);
      emit(ContactLoaded(contactss: contactsResponse.contacts));
    } else {
      print('Failed to load contacts'); // طباعة رسالة الخطأ لفحصها
      emit(ContactError('Failed to load contacts'));
    }
  } catch (e) {
    print('Error: $e'); // طباعة الاستثناء لفحصه
    emit(ContactError(e.toString()));
  }
}

   

}