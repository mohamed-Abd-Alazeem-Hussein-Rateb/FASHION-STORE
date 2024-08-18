import 'package:flutter/material.dart';
import 'package:flutter_application_1/layouts/layout_cubit.dart';
import 'package:flutter_application_1/layouts/layout_states.dart';
import 'package:flutter_application_1/screens/Change_Password_Screen.dart';
import 'package:flutter_application_1/screens/Register_screen.dart';
import 'package:flutter_application_1/screens/Update_Profile_Screen.dart';
import 'package:flutter_application_1/widget/costant_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/authentication_screen/auth_cubit/auth_cubit.dart';
import 'package:flutter_application_1/authentication_screen/auth_cubit/auth_states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, layoutState) {},
        builder: (context, layoutState) {
          return BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, authState) {
              if (authState is LogoutSuccessState) {
                // Navigate to login screen or show success message
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  RegisterScreen()));
              } else if (authState is LogoutErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(authState.message)),
                );
              }
            },
            builder: (context, authState) {
              final layoutCubit = BlocProvider.of<LayoutCubit>(context);
              final authCubit = BlocProvider.of<AuthCubit>(context);
              return Scaffold(
                backgroundColor: thirdColor,
                body: layoutCubit.userModel != null
                    ? Padding(
                        padding: const EdgeInsets.all(18.0),
                        child:ListView(
                          children: [
                             Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 80,
                              backgroundImage: NetworkImage(layoutCubit.userModel!.image!),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              layoutCubit.userModel!.name!,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              layoutCubit.userModel!.email!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              layoutCubit.userModel!.phone!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Card(
                              color: fourthColor,
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                leading: Icon(Icons.person, color: Colors.blue),
                                title: Text(layoutCubit.userModel!.name!),
                              ),
                            ),
                            Card(
                              color: fourthColor,
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                leading: Icon(Icons.email, color: Colors.blue),
                                title: Text(layoutCubit.userModel!.email!),
                              ),
                            ),
                            Card(
                              color: fourthColor,
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                leading: Icon(Icons.phone, color: Colors.blue),
                                title: Text(layoutCubit.userModel!.phone!),
                              ),
                            ),
                            
                             Card(
                              color: fourthColor,
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                leading:const Icon(Icons.password_outlined, color: Colors.blue),
                                title: TextButton(
                                  onPressed: () {
                                   Navigator.push(context, MaterialPageRoute(builder: (context) =>  ChangePasswordScreen()));
                                    
                                  },
                                  child: const Text(
                                    'change password',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Card(
                              color: fourthColor,
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                leading:const Icon(Icons.security_update_sharp, color: Colors.blue),
                                title: TextButton(
                                  onPressed: () {
                                   Navigator.push(context, MaterialPageRoute(builder: (context) =>  UpdateProfileScreen()));
                                    
                                  },
                                  child: const Text(
                                    'update profile',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Card(
                              color: fourthColor,
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                leading: Icon(Icons.logout, color: Colors.blue),
                                title: TextButton(
                                  onPressed: () {
                                    authCubit.logout();
                                    
                                  },
                                  child: const Text(
                                    'Logout',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                          ],
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              );
            },
          );
        },
      );
    
  }
}
