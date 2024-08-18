import 'package:flutter/material.dart';
import 'package:flutter_application_1/layouts/layout_cubit.dart';
import 'package:flutter_application_1/layouts/layout_states.dart';
import 'package:flutter_application_1/widget/costant_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: thirdColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Current Password',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter current password',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'New Password',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter new password',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Confirm New Password',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            BlocConsumer<LayoutCubit, LayoutStates>(listener: (context, state) {
              if (state is ChangePasswordSuccessState) {
                showSnackBarMessage(
                    context, 'Password changed successfully', true);
                Navigator.pop(context);
              } else if (state is ChangePasswordErrorState) {
                showSnackBarMessage(context, state.error, false);
              }
            }, builder: (context, state) {
              if (state is ChangePasswordLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Center(
                child: ElevatedButton(
                  
                  onPressed: () {
                    if (currentPasswordController.text.trim() ==
                        changePassword) {
                      if (newPasswordController.text.length >= 6) {
                        cubit.ChangePassword(
                            currentPassword: changePassword.toString(),
                            newPassword: newPasswordController.text.toString());
                      } else {
                        showSnackBarMessage(context,
                            'Password must be at least 6 characters', false);
                      }
                    } else {
                      showSnackBarMessage(
                          context, 'Wrong current password , try later', false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: fourthColor,
                    shape: const StadiumBorder(),
                    minimumSize: const Size.fromHeight(50),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  ),
                  child: Text(
                    state is ChangePasswordLoadingState
                        ? 'Loading...'
                        : 'Change Password',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void showSnackBarMessage(
      BuildContext context, String message, bool forSucessOrFalier) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: forSucessOrFalier ? Colors.green : Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
