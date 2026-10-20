import 'package:beauty_app/core/constants/app_colors.dart';
import 'package:beauty_app/features/home/presentation/cubit/product_cubit.dart';
import 'package:beauty_app/features/home/presentation/cubit/product_states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProductCubit.get(context);
        return Scaffold(
          appBar: AppBar(title: Text("Lumière")),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          cubit.searchProducts(query: value);
                        },
                        controller: _searchController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search mascara,lipstick,pallette",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: AppColors.lightBorder,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: AppColors.lightBorder,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gap(8),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.lightTextPrimary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.tune, color: AppColors.lightBackground),
                    ),
                  ],
                ),
                Gap(24),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (state is GetProductsLoadingState ||
                          state is SearchProductsLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is GetProductsErrorState) {
                        return Center(child: Text(state.error));
                      }
                      if (state is SearchProductsErrorState) {
                        return Center(child: Text(state.error));
                      }

                      final displayedProducts =
                          _searchController.text.trim().isEmpty
                          ? cubit.products
                          : cubit.searchedProducts;
                      if (displayedProducts.isEmpty) {
                        return const Center(child: Text("No products found"));
                      }

                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              childAspectRatio: 5 / 8,
                            ),
                        itemBuilder: (context, index) {
                          var product = displayedProducts[index];
                          return Material(
                            color: Theme.of(context).cardTheme.color,
                            borderRadius: BorderRadius.circular(16),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () => context.push(
                                '/productDetails',
                                extra: product,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: product.imageUri,
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                              baseColor: Colors.grey.shade100,
                                              highlightColor:
                                                  Colors.grey.shade300,
                                              child: Container(
                                                width: double.infinity,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                              ),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        fit: BoxFit.fill,

                                        width: double.infinity,
                                        height: 150,
                                      ),
                                      Positioned(
                                        top: 8,
                                        left: 8,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),

                                          decoration: BoxDecoration(
                                            color: AppColors.lightBackground,
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          child: Text(
                                            "-${product.discountPercentage.toString()} %",
                                            style: TextStyle(
                                              color: AppColors.lightTextPrimary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.brand,
                                          style: TextStyle(
                                            color: AppColors.lightTextSecondary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),

                                        Text(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          product.title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.lightTextPrimary,
                                          ),
                                        ),
                                        Gap(4),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 16,
                                            ),
                                            Text(
                                              product.rate.toString(),
                                              style: TextStyle(
                                                color:
                                                    AppColors.lightTextPrimary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(4),
                                        Row(
                                          children: [
                                            Text(
                                              "${product.price.toStringAsFixed(1)} \$",
                                              style: TextStyle(
                                                color:
                                                    AppColors.lightTextPrimary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Gap(4),
                                            Text(
                                              (double.parse(
                                                        product.price
                                                            .toString(),
                                                      ) -
                                                      ((double.parse(
                                                                product.price
                                                                    .toString(),
                                                              ) *
                                                              double.parse(
                                                                product
                                                                    .discountPercentage
                                                                    .toString(),
                                                              )) /
                                                          100))
                                                  .toStringAsFixed(2),
                                              style: const TextStyle(
                                                color:
                                                    AppColors.lightTextPrimary,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                decorationColor: AppColors
                                                    .lightTextSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: displayedProducts.length,
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
