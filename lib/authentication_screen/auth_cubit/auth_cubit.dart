import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/authentication_screen/auth_cubit/auth_states.dart';
import 'package:flutter_application_1/models/user_modle_banners.dart';
import 'package:flutter_application_1/shared/network/local_network.dart';
import 'package:flutter_application_1/widget/costant_color.dart';
import 'package:http/http.dart' as http;

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());
  void Register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      emit(AuthLoadingState());
      http.Response response = await http.post(
          Uri.parse('https://student.valuxapps.com/api/register'),
          headers: {
            'lang': 'en',
          },
          body: {
            'email': email,
            'password': password,
            'name': name,
            'phone': phone
          });
      var responsebody = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (responsebody['status'] == true) {
          await CacheNetwork.insertToCache(key: 'token', value: responsebody['data']['token']); // هنا بحفظ الـ token في الـ cache تبع ال sharedpreference

          await CacheNetwork.insertToCache(key: 'password', value: password);
          token = CacheNetwork.getCache(key: 'password');
          changePassword = CacheNetwork.getCache(key: 'token');
          String message = responsebody['message']; // رسالة النجاح من الـ API
          emit(RegisterSuccessState(messagesucess: message));
        } else {
          String message = responsebody['message']; // رسالة الخطأ من الـ API
          emit(RegisterErrorState(message: message));
        }
      } else {
        emit(RegisterErrorState(message: 'Unexpected error occurred.'));
      }
    } catch (e) {
      emit(RegisterErrorState(message: e.toString()));
    }
  }

  void Login({required String email, required String password}) async {
    try {
      emit(logloadingState());
      http.Response response = await http
          .post(Uri.parse('https://student.valuxapps.com/api/login'), headers: {
        'lang': 'en',
      }, body: {
        'email': email,
        'password': password,
      });
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (data['status'] == true) {
          String message = data['message']; // رسالة النجاح من الـ API
          emit(LoginSuccessState(messagesucess: message));
        } else {
          String message = data['message']; // رسالة الخطأ من الـ API
          emit(LoginErrorState(message: message));
        }
      } else {
        emit(LoginErrorState(message: 'Unexpected error occurred.'));
      }
    } catch (e) {
      emit(LoginErrorState(message: e.toString()));
    }
  }

  void logout() async {
    try {
      emit(AuthLoadingState());
      String? token = await CacheNetwork.getCache(key: 'token');
      http.Response response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/logout'),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
          'lang': 'en',
        },
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == true) {
        await CacheNetwork.clearCache();
        emit(LogoutSuccessState(message: data['message']));
      } else {
        emit(LogoutErrorState(message: data['message'] ?? 'Error logging out'));
      }
    } catch (e) {
      emit(LogoutErrorState(message: e.toString()));
    }
  }

  List<BannersModle> banner = []; //عشان هنستقبل ال list ال جايمن ال Api تحت
  void GetDataBanner() async {
    try {
      emit(LoadingBannerState());
      http.Response response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/banners'),
        headers: {
          'lang': 'en',
        },
      );
      var responsedata = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // print('response is  $responsedata'); // عشان يظهر ليا في الـDebug

        for (var element in responsedata['data']) {
          banner.add(BannersModle.fromJson(
              element)); //element ده يعتر ال map في ال list ال راجعه من ال Api
        }
        emit(SuccessBannerState());
      } else {
        emit(ErrorBannerState(error: responsedata['message']));
      }
    } catch (e) {
      print(e.toString());
      emit(ErrorBannerState(error: e.toString()));
    }
  }
}
