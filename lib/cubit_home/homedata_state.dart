part of 'homedata_cubit.dart';

@immutable
sealed class HomedataState {}

final class HomedataInitial extends HomedataState {}

final class HomedataLoading extends HomedataState {}

final class Homedatasuccess extends HomedataState {}

final class HomedataError extends HomedataState {
  final String message;

  HomedataError(this.message);
}
class homedatafilterSuccessState extends HomedataState {}
