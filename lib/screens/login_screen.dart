import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/authentication_screen/auth_cubit/auth_cubit.dart';
import 'package:flutter_application_1/authentication_screen/auth_cubit/auth_states.dart';
import 'package:flutter_application_1/screens/Home_screen.dart';
import 'package:flutter_application_1/widget/costant_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration:const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/auth_background.png'),
                  fit: BoxFit.fill)),
          child: BlocConsumer<AuthCubit, AuthStates>( 
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomeScreen()));
            } else if (state is LoginErrorState) {
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
              return Column(children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child:const Text(
                  'login to continue procees',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration:const BoxDecoration(
                  color: thirdColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(55),
                      topRight: Radius.circular(55)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'login ',
                        style:
                            TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (emailController.text.isEmpty) {
                            return 'Please enter your email';
                          } else {
                            return null;
                          }
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                            prefixIcon:const Icon(Icons.email),
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (passwordController.text.isEmpty && value!.length <= 8){
                            return 'Please enter your password';
                          } else {
                            return null;
                          }
                        },
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()==true) {

                            BlocProvider.of<AuthCubit>(context).Login(
                              email: emailController.text,
                              password: passwordController.text,
                            );

                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: secondColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child:const Center(
                            child: Text(
                             State is logloadingState ? 'processing...' : 'Login',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account ?'),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(color: mainColor),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]
          );
            },
          ),
        ),
      ),
    );
  }
}
