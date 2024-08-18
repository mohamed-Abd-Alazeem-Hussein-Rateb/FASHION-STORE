import 'package:flutter/material.dart';
import 'package:flutter_application_1/layouts/layout_cubit.dart';
import 'package:flutter_application_1/layouts/layout_states.dart';
import 'package:flutter_application_1/widget/costant_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    // استدعاء الدالة مرة واحدة عند تهيئة الصفحة
    final cubit = BlocProvider.of<LayoutCubit>(context);
    if (!_isDataLoaded) {
      cubit.GetFavouriteData();
      _isDataLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);

    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if (state is FavouriteError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error loading data')),
          );
        }
      },
      builder: (context, state) { 
        if (state is FavouriteLoading && !_isDataLoaded) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is Favouritesuccess || _isDataLoaded) {
          return Scaffold(
            body: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      prefixIcon: Icon(Icons.search),
                      labelText: 'Search',
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: cubit.favourite.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(6.0),
                          decoration: const BoxDecoration(
                            color: fourthColor,
                          ),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: cubit.favourite[index].image!,
                                height: 110,
                                width: 110,
                                fadeInCurve: Curves.bounceIn,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.fill,
                              ),
                              const SizedBox(width: 26),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cubit.favourite[index].name!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      '${cubit.favourite[index].price} \$',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('id: ${cubit.favourite[index].id}'),
                                    const SizedBox(height: 10),
                                    Container(
                                      padding: const EdgeInsets.all(4.0),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color: mainColor,
                                      ),
                                      child: MaterialButton(
                                        onPressed: () {
                                          cubit.addOrRemoveFromFavourite(
                                              id: cubit.favourite[index].id!);
                                        },
                                        child: const Text(
                                          'Remove',
                                          style: TextStyle(color: Colors.white),
                                        ),
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
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
