

abstract class LayoutStates {
  get contacts => null;
}

class LayoutInitialState extends LayoutStates {}

class GetDataErrorState extends LayoutStates {
  final String error;
  GetDataErrorState({required this.error});
}
class GetDataSuccessState extends LayoutStates {}

class GetDataLoadingState extends LayoutStates {}

class LayoutBottomNavState extends LayoutStates {}


 class LoadingCategoryState extends LayoutStates {}

  class SuccessCategoryState extends LayoutStates {}

  class ErrorCategoryState extends LayoutStates {
    final String error; 
    ErrorCategoryState({required this.error});
  }


class homedatafilterSuccessState extends LayoutStates {}
 

 class Favouritesuccess extends LayoutStates {}
  class FavouriteError extends LayoutStates {}
  class FavouriteLoading extends LayoutStates {}


   class AddOrRemoveFromFavouriteLoadingState extends LayoutStates {}
  class AddOrRemoveFromFavouriteSuccessState extends LayoutStates {}
  class AddOrRemoveFromFavouriteErrorState extends LayoutStates {}


  class GetDataCartLoadingState extends LayoutStates {}
  class GetDataCartSuccessState extends LayoutStates {}
  class GetDataCartErrorState extends LayoutStates {}
   
   class AddOrRemoveFromCartLoadingState extends LayoutStates {}
  class AddOrRemoveFromCartSuccessState extends LayoutStates {}
  class AddOrRemoveFromCartErrorState extends LayoutStates {}

  class ChangePasswordLoadingState extends LayoutStates {}
  class ChangePasswordSuccessState extends LayoutStates {}
  class ChangePasswordErrorState extends LayoutStates {
    final String error;
    ChangePasswordErrorState( this.error);
  }
   
   class UpdateProfileSuccessState extends LayoutStates {}
  class UpdateProfileErrorState extends LayoutStates {
    final String error;
    UpdateProfileErrorState( this.error);
  }
   class UpdateProfileLoadingState extends LayoutStates {}
         