import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layouts/layout_cubit.dart';
import 'package:flutter_application_1/layouts/layout_states.dart';
import 'package:flutter_application_1/widget/costant_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
  cubit.getDataCart();
  return  BlocConsumer<LayoutCubit, LayoutStates>(
  listener: (context, state) {
    // يمكن إضافة منطق إضافي عند تحديث الحالة هنا
  },
  builder: (context, state) {
    

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: cubit.cart.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: cubit.cart.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 122,
                            width: 110,
                            padding: const EdgeInsets.all(8.0),
                            color: fourthColor,
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: cubit.cart[index].image!,
                                  height: 110,
                                  width: 110,
                                  fadeInCurve: Curves.bounceIn,
                                  placeholder: (context, url) => const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                  fit: BoxFit.fill,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cubit.cart[index].name!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
                                      Text('\$ ${cubit.cart[index].price}'),
                                      SizedBox(height: 5),
                                      if (cubit.cart[index].price != cubit.cart[index].oldPrice)
                                        Text(
                                          '\$ ${cubit.cart[index].oldPrice}',
                                          style: const TextStyle(decoration: TextDecoration.lineThrough),
                                        ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            OutlinedButton(
                                              onPressed: () {
                                                cubit.addOrRemoveFromFavourite(id: cubit.cart[index].id!);
                                              },
                                              child: Icon(
                                                Icons.favorite,
                                                color: cubit.favouriteId.contains(cubit.cart[index].id.toString()) ? Colors.red : Colors.grey,
                                                size: 32,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                cubit.addOrRemoveFromCart(id: cubit.cart[index].id!);
                                                
                                              },
                                              child:const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 32,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  },
);


  }
}



// BlocConsumer<LayoutCubit, LayoutStates>(
    
//   listener: (context, state) {},
//   builder: (context, state) {
//     var cubit = BlocProvider.of<LayoutCubit>(context);
     
//     if (state is GetDataCartLoadingState) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     } else if (state is GetDataCartSuccessState) {
//       return Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: cubit.cart.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
                        
//                         height: 110,
//                         width: 95,
//                         padding: const EdgeInsets.all(8.0),
//                         color: fourthColor,
//                         child: Row(
//                           children: [
//                             CachedNetworkImage(
//                               imageUrl: cubit.cart[index].image!,
//                               height: 110,
//                               width: 110,
//                               fadeInCurve: Curves.bounceIn,
//                               placeholder: (context, url) =>
//                                   const CircularProgressIndicator(),
//                               errorWidget: (context, url, error) =>
//                                   const Icon(Icons.error),
//                               fit: BoxFit.fill,
//                             ),
//                             const SizedBox(width: 10),
//                             Expanded(
//                               child: Column(
//                                 children: [
//                                   Text(cubit.cart[index].name!, maxLines: 1,
//                                             overflow: TextOverflow.ellipsis,
//                                             style: const TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold),
//                                   ),
//                                   Text(cubit.cart[index].price.toString()),
//                                   Text('id: ${cubit.cart[index].id}'),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     } else if (state is GetDataCartErrorState) {
//       return const Center(
//         child: Text('Error'),
//       );
//     }
//     return const Center(
//       child: Text('Error//'),
//     );
//   },
// );