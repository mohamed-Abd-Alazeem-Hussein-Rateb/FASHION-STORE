
import 'package:flutter/material.dart';
import 'package:flutter_application_1/authentication_screen/auth_cubit/auth_cubit.dart';
import 'package:flutter_application_1/authentication_screen/auth_cubit/auth_states.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/widget/coustm_Text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginScreen()));
          }else if (state is RegisterErrorState) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.message),
        backgroundColor: Colors.red, // تغيير لون الخلفية للخطأ
        duration: Duration(seconds: 3), // حدد مدة العرض بالثواني
        action: SnackBarAction(
          label: 'Retry',
          textColor: Colors.white, // لون النص للزر
          onPressed: () {
            // إجراء يتم عند الضغط على الزر
          },
        ),
      ),
    );
  }
},
        builder: (context, state) {
          var cubit = BlocProvider.of<AuthCubit>(context);
                    return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Sign up',
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    coustm_Text_field(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      name: 'Name',
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 26),
                    coustm_Text_field(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      name: 'Email',
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 26),
                    coustm_Text_field(
                      isSecure: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty&&value.length<=8) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      name: 'Password',
                      icon: Icons.lock,
                    ),
                    const SizedBox(height: 26),
                    coustm_Text_field(
                      controller: _phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty&&value.length<=11) {
                          return 'Please enter your phone';
                        }
                        return null;
                      },
                      name: 'Phone',
                      icon: Icons.phone,
                    ),
                    const SizedBox(height: 32),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()==true) {
                          cubit.Register(
                            email: _emailController.text,
                            password: _passwordController.text,
                            name: _nameController.text,
                            phone: _phoneController.text,
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:  Center(
                          child: Text(
                           state is AuthLoadingState ? 'Loading...' : 'Sign up',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginScreen()));
                          },
                          child: const Text(
                             'Sign in',
                            style: TextStyle(color: Colors.blue, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
  }
}
