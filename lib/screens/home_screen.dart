import 'package:flutter/material.dart';
import 'package:flutter_application_1/authentication_screen/auth_cubit/auth_cubit.dart';
import 'package:flutter_application_1/authentication_screen/auth_cubit/auth_states.dart';
import 'package:flutter_application_1/cubit_home/homedata_cubit.dart';
import 'package:flutter_application_1/layouts/layout_cubit.dart';
import 'package:flutter_application_1/models/Home_data_modle.dart';
import 'package:flutter_application_1/widget/costant_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    final cubit = BlocProvider.of<AuthCubit>(context);
    final layoutCubit = BlocProvider.of<LayoutCubit>(context);
    final homedataCubit = BlocProvider.of<HomedataCubit>(context);
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoadingBannerState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is SuccessBannerState) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) {
                        homedataCubit.FilterData(value: value);
                      },
                      decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        suffixIcon: Icon(Icons.clear),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  cubit.banner.isEmpty
                      ? SizedBox()
                      : SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0, left: 10),
                            child: PageView.builder(
                              controller: controller,
                              padEnds: false,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(right: 12),
                                  child: Image.network(
                                    cubit.banner[index].image!,
                                    fit: BoxFit.fill,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                  SizedBox(height: 10),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 5,
                      axisDirection: Axis.horizontal,
                      effect: const SlideEffect(
                        spacing: 8.0,
                        radius: 25.0,
                        dotWidth: 16.0,
                        dotHeight: 16.0,
                        paintStyle: PaintingStyle.stroke,
                        strokeWidth: 1.5,
                        dotColor: Colors.grey,
                        activeDotColor: secondColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'View All',
                        style: TextStyle(fontSize: 20, color: secondColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  layoutCubit.category.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(
                          height: 90,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0, left: 10),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: layoutCubit.category.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 7),
                                  child: CircleAvatar(
                                    radius: 36,
                                    backgroundImage: NetworkImage(
                                      layoutCubit.category[index].image!,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                  const SizedBox(height: 12),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'products',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'View All',
                        style: TextStyle(fontSize: 20, color: secondColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  BlocConsumer<HomedataCubit, HomedataState>(
                      listener: (context, state) {
                    if (state is Homedatasuccess) {
                      ScaffoldMessenger(
                        child: const SnackBar(content: Text('data loaded')),
                      );
                    } else if (state is ErrorBannerState) {
                      ScaffoldMessenger(
                        child: const SnackBar(
                            content: Text('failed to data loaded')),
                      );
                    }
                  }, builder: (context, state) {
                    return homedataCubit.homeData.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: homedataCubit.homedatafilter.isEmpty
                                ? homedataCubit.homeData.length
                                : homedataCubit.homedatafilter.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.7,
                            ),
                            itemBuilder: (context, index) {
                              return productItem(
                                model: homedataCubit.homedatafilter.isEmpty
                                    ? homedataCubit.homeData[index]
                                    : homedataCubit.homedatafilter[index],
                                cubit: homedataCubit,
                                layoutCubit: layoutCubit,
                              );
                            },
                          );
                  }),
                ],
              ),
            ),
          );
        } else if (state is ErrorBannerState) {
          return const Scaffold(
            body: Center(
              child: Text('Failed to load banners'),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

Widget productItem({required HomeDataModle model, required HomedataCubit cubit, required LayoutCubit layoutCubit}) {
  return Stack(
    alignment: Alignment.topRight,
    children: [
      Container(
        color: Colors.grey.withOpacity(0.2),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: model.image!,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 10),
            Text(
              model.name!,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${model.oldPrice}\$',
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${model.oldPrice}\$',
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 10,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                
                GestureDetector(
                  child: Icon(
                    Icons.favorite,
                    size: 20,
                    color: layoutCubit.favouriteId.contains(model.id.toString())
                        ? Colors.red
                        : Colors.grey,
                  ),
                  onTap: () {
                    layoutCubit.addOrRemoveFromFavourite(id: model.id!);
                  },
                )
              ],
            ),
          ],
        ),
      ),
      
      GestureDetector(
        onTap: () {
          layoutCubit!.addOrRemoveFromCart(id: model.id!);
        },
        child: Container(
          height: 30,
          width: 30,
          alignment: Alignment.topRight,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.shopping_cart,
            size: 20,
            color: layoutCubit!.cartId.contains(model.id.toString())
                ? Colors.red
                : Colors.white,
          ),
        ),
      )
    ],
  );
}
