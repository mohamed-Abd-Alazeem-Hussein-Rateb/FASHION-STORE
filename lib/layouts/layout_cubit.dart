import 'package:flutter_application_1/models/Home_data_modle.dart';
import 'package:flutter_application_1/models/category_modle.dart';
import 'package:flutter_application_1/screens/Home_screen.dart';
import 'package:flutter_application_1/screens/contactus_screen.dart';
import 'package:flutter_application_1/shared/network/local_network.dart';
import 'package:flutter_application_1/widget/costant_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/layouts/layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/cart_screen.dart';
import 'package:flutter_application_1/screens/category_screen.dart';
import 'package:flutter_application_1/screens/favourite_screen.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'package:flutter_application_1/models/user_modle.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  int bottomcurrentindex = 0;

  List<Widget> layoutscreen = [
    HomeScreen(),
    FavouriteScreen(),
    CartScreen(),
    CategoryScreen(),
    ProfileScreen(),
    ContactUsPage(),
  ];

  void changeBottomNav(int index) {
    bottomcurrentindex = index;
    emit(LayoutBottomNavState());
  }

  UserModle? userModel;

  Future<void> getUserData() async {
    // Profile data
    try {
      emit(GetDataLoadingState());
      http.Response response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/profile'),
        headers: {
          'Authorization': token!,
          'lang': 'en',
        },
      );
      var responsedata = jsonDecode(response.body);
      if (response.statusCode == 200) {
        userModel = UserModle.fromJson(responsedata['data']);
        emit(GetDataSuccessState());
      } else {
        emit(GetDataErrorState(error: responsedata['message']));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  List<CategoryModle> category = [];

  void GetDataCategory() async {
    try {
      emit(LoadingCategoryState());
      http.Response response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/categories'),
        headers: {
          'lang': 'en',
        },
      );
      var responsedata = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var element in responsedata['data']['data']) {
          category.add(CategoryModle.fromJson(element));
        }
        emit(SuccessCategoryState());
      } else {
        emit(ErrorCategoryState(error: responsedata['message']));
      }
    } catch (e) {
      print(e.toString());
      emit(ErrorCategoryState(error: e.toString()));
    }
  }
  List<HomeDataModle> favourite = [];
  Set<String> favouriteId = {};

  Future<void> GetFavouriteData() async {
    try {
      emit(FavouriteLoading());
      favourite.clear();
      http.Response response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/favorites'),
        headers: {
          'Authorization': token!,
          'lang': 'en',
        },
      );
      var responsedata = jsonDecode(response.body);
      if (response.statusCode == 200) {
        favourite.clear();
        favouriteId.clear();
        for (var element in responsedata['data']['data']) {
          favourite.add(HomeDataModle.fromJson(element['product']));
          favouriteId.add(element['product']['id'].toString());
        }
        emit(Favouritesuccess());
      } else {
        emit(FavouriteError());
      }
    } catch (e) {
      print(e.toString());
      emit(FavouriteError());
    }
  }

  void addOrRemoveFromFavourite({required int id}) async {
    try {
      emit(AddOrRemoveFromFavouriteLoadingState());
      http.Response response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/favorites'),
        headers: {
          'Authorization': token!,
          'lang': 'en',
        },
        body: {
          'product_id': id.toString(),
        },
      );
      var responsedata = jsonDecode(response.body);
      if (responsedata['status'] == true) {
        if (favouriteId.contains(id.toString())) {
          favouriteId.remove(id.toString());
        } else {
          favouriteId.add(id.toString());
        }
        await GetFavouriteData();
        emit(AddOrRemoveFromFavouriteSuccessState());
      } else {
        emit(AddOrRemoveFromFavouriteErrorState());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  List<HomeDataModle> cart = [];
  Set<String> cartId = {};
  Future<void> getDataCart() async {
    try {
      emit(GetDataCartLoadingState());
      http.Response response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/carts'),
        headers: {
          'Authorization': token!,
          'lang': 'en',
        },
      );
      var responsedata = jsonDecode(response.body);
      if (response.statusCode == 200) {
        cart.clear(); // تفريغ القائمة قبل إضافة البيانات الجديدة
        for (var element in responsedata['data']['cart_items']) {
          cart.add(HomeDataModle.fromJson(element['product']));
          cartId.add(element['product']['id']
              .toString()); // تفريغ القائمة قبل إضافة البيانات الجديدة
        }
        emit(GetDataCartSuccessState());
      } else {
        emit(GetDataCartErrorState());
      }
    } catch (e) {
      print(e.toString());
      emit(GetDataCartErrorState());
    }
  }

  void addOrRemoveFromCart({required int id}) async {
    try {
      emit(AddOrRemoveFromCartLoadingState());
      http.Response response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/carts'),
        headers: {
          'Authorization': token!,
          'lang': 'en',
        },
        body: {
          'product_id': id.toString(),
        },
      );
      var responsedata = jsonDecode(response.body);
      if (responsedata['status'] == true) {
        if (cartId.contains(id.toString())) {
          cartId.remove(id.toString());
        } else {
          cartId.add(id.toString());
        }
        await getDataCart();
        emit(AddOrRemoveFromCartSuccessState());
      } else {
        emit(AddOrRemoveFromCartErrorState());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void ChangePassword(
      {required String currentPassword, required String newPassword}) async {
    try {
      emit(ChangePasswordLoadingState());
      http.Response response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/change-password'),
        headers: {
          'Authorization': token!,
          'lang': 'en',
        },
        body: {
          'current_password': currentPassword,
          'new_password': newPassword,
        },
      );
      var responsedata = jsonDecode(response.body);
      if (responsedata['status'] == true || response.statusCode == 200) {
        await CacheNetwork.insertToCache(key: 'password', value: newPassword);
        currentPassword = CacheNetwork.getCache(key: 'password');
        emit(ChangePasswordSuccessState());
      } else {
        emit(ChangePasswordErrorState(responsedata['message']));
      }
    } catch (e) {
      print(e.toString());
      emit(ChangePasswordErrorState(e.toString()));
    }
  }

  
  Future<void> updateProfile({
    required String name,
    required String phone,
    required String email,

  }) async {
    try {
      emit(UpdateProfileLoadingState());
      http.Response response = await http.put(
        Uri.parse('https://student.valuxapps.com/api/update-profile'),
        headers: {
          'Authorization': token!,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'phone': phone,
          'email': email,
        }),
      );

      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['status'] == true){
          await getUserData(); // تحديث البيانات في البروفايل بعد التعديل ويجبها قبل ما اعمل تحديث ل الحاله
        emit(UpdateProfileSuccessState());
      } else {
        emit(UpdateProfileErrorState(responseData['message']));
      }

    } catch (e) { 
      print(e.toString());
    }
  }
}
