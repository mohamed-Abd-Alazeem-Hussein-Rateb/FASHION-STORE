import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/widget/costant_color.dart';
import 'package:meta/meta.dart';
import 'package:flutter_application_1/models/Home_data_modle.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'homedata_state.dart';

class HomedataCubit extends Cubit<HomedataState> {
  HomedataCubit() : super(HomedataInitial());

   List<HomeDataModle> homeData = [];
 Future<void> GetHomeData() async {
 
    try {
      emit(HomedataLoading());
      http.Response response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/home'),
        headers: {'Authorization': token!, 'lang': 'en'},
      );
      var responsedata = jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var element in responsedata['data']['products']) {
          homeData.add(HomeDataModle.fromJson(element));
        }
      
        emit(Homedatasuccess());
      } else {
        print('Failed to load contacts');
        emit(HomedataError('Failed to load contacts'));
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  List<HomeDataModle> homedatafilter = [];
  void FilterData({required String value}) {
    homedatafilter = homeData
        .where(
          (element) =>
              element.name!.toLowerCase().startsWith(value.toLowerCase()),
        )
        .toList(); 
    emit(homedatafilterSuccessState());
  }
}
