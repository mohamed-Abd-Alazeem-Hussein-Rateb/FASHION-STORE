import 'package:flutter/material.dart';
import 'package:flutter_application_1/layouts/layout_cubit.dart';
import 'package:flutter_application_1/layouts/layout_states.dart';
import 'package:flutter_application_1/widget/costant_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProfileScreen extends StatefulWidget {
 const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    nameController.text = cubit.userModel!.name!; // عشان ابعت بينات ال المستخدم و تظهر في في صفحه بتاعت  update profile
    emailController.text = cubit.userModel!.email!; //نفس كلام ال فوق 
    phoneController.text = cubit.userModel!.phone!;// نفس كلام ال فوق 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: thirdColor,
        title: const Text('Update Profile'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    labelText: 'Phone',
                  ),
                ),
                const SizedBox(height: 20),
                BlocConsumer<LayoutCubit, LayoutStates>(
                  listener: (context, state) {
                    if (state is UpdateProfileSuccessState) {
                      showSnackBarMessage(
                          context, 'Profile updated successfully', true);
                      Navigator.pop(context);
                    } else if (state is UpdateProfileErrorState) {
                      showSnackBarMessage(context, state.error, false);
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: fourthColor,
                        shape: const StadiumBorder(),
                        minimumSize: const Size.fromHeight(50),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 13),
                      ),
                      onPressed: () {
                        if (nameController.text.isNotEmpty &&
                            emailController.text.isNotEmpty &&
                            phoneController.text.isNotEmpty) {
                          cubit.updateProfile(
                            name: nameController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill all fields'),
                            ),
                          );
                        }
                      },
                      child:state is UpdateProfileLoadingState
                            ? const CircularProgressIndicator(color: thirdColor,)
                            : const Text(
                         'Update Profile',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
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
