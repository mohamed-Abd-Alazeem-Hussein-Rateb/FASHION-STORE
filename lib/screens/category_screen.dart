import 'package:flutter/material.dart';
import 'package:flutter_application_1/layouts/layout_cubit.dart';
import 'package:flutter_application_1/widget/costant_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var categoryes = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:GridView.builder(
            itemCount: categoryes.category.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
            ),
           itemBuilder: (context,index) {
             return Container(
              padding: EdgeInsets.all(8.0),
              color: fourthColor,
              child: Column(
                children: [
                 Expanded(child: Image.network(categoryes.category[index].image!,fit: BoxFit.fill,)),
                  Text(categoryes.category[index].name!),
                ],

              ),
            );
           }
           ),
        ),

      ),
    );
  }
}