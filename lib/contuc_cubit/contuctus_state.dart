import 'package:flutter_application_1/models/contuctus_modle.dart';

abstract class ContuctusState {}

class ContactInitial extends ContuctusState {}

class ContactLoading extends ContuctusState {}

class ContactLoaded extends ContuctusState {
  final List<Contact> contactss;

  ContactLoaded({required this.contactss});
}

class ContactError extends ContuctusState {
  final String message;

  ContactError(this.message);
}


