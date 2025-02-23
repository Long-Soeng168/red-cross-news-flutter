// ignore_for_file: prefer_const_constructors

import 'package:red_cross_news_app/components/cards/database_card.dart';
import 'package:red_cross_news_app/components/my_drawer.dart';
import 'package:red_cross_news_app/components/my_list_header.dart';
import 'package:red_cross_news_app/components/my_slide_show.dart';
import 'package:red_cross_news_app/models/category.dart';
import 'package:red_cross_news_app/models/product.dart';
import 'package:red_cross_news_app/pages/shops/product_detail_page.dart';
import 'package:red_cross_news_app/pages/shops/products_list_page.dart';
import 'package:red_cross_news_app/services/category_service.dart';
import 'package:red_cross_news_app/services/product_service.dart';
import 'package:red_cross_news_app/services/slide_service.dart';
import 'package:flutter/material.dart';
import 'package:red_cross_news_app/components/cards/product_card.dart';

class ShopsPage extends StatefulWidget {
  const ShopsPage({super.key});

  @override
  State<ShopsPage> createState() => _ShopsPageState();
}

class _ShopsPageState extends State<ShopsPage> {
  List<Product> products = [];
  bool isLoadingProducts = true;
  bool isLoadingProductsError = false;
  bool hasMoreProducts = true;
  bool isLoadingMore = false;
  int currentPage = 1;

  List<String> slidesMiddle = [];
  List<String> slides = [];
  bool isLoadingSlide = true;
  bool isLoadingSlideError = false;

  List<Category> categories = [];
  bool isLoadingCategories = true;
  bool isLoadingCategoriesError = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getSlides();
    getCategories();
    getProducts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !isLoadingMore) {
        loadMoreProducts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> getSlides() async {
    try {
      // Fetch products outside of setState
      final fetchedSlides = await SlideService.fetchSlides(position: 'shop');
      final fetchedSlidesMiddle =
          await SlideService.fetchSlides(position: 'home_middle');
      // Update the state
      setState(() {
        slides = fetchedSlides;
        slidesMiddle = fetchedSlidesMiddle;
        isLoadingSlide = false;
      });
    } catch (error) {
      // Handle any errors that occur during the fetch
      setState(() {
        isLoadingSlide = false;
        isLoadingSlideError = true;
      });
      // You can also show an error message to the user
      print('Failed to load Slide: $error');
    }
  }

  Future<void> getCategories() async {
    try {
      // Fetch products outside of setState
      final fetchedCategories = await CategoryService.fetchCategories();
      // Update the state
      setState(() {
        categories = fetchedCategories;
        isLoadingCategories = false;
      });
    } catch (error) {
      // Handle any errors that occur during the fetch
      setState(() {
        isLoadingCategories = false;
        isLoadingCategoriesError = true;
      });
      // You can also show an error message to the user
      print('Failed to load Catogries: $error');
    }
  }

  Future<void> getProducts() async {
    try {
      final fetchedProducts = await ProductService.fetchProducts(page: 1);
      setState(() {
        products = fetchedProducts;
        isLoadingProducts = false;
      });
    } catch (error) {
      setState(() {
        isLoadingProducts = false;
        isLoadingProductsError = true;
        isLoadingMore = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load Data'),
        ),
      );
    }
  }

  Future<void> loadMoreProducts() async {
    if (!hasMoreProducts || isLoadingMore) {
      return;
    }

    setState(() {
      isLoadingMore = true;
    });

    try {
      currentPage++;
      final fetchedProducts =
          await ProductService.fetchProducts(page: currentPage);

      setState(() {
        products.addAll(fetchedProducts);
        isLoadingMore = false;
      });

      if (fetchedProducts.isEmpty) {
        hasMoreProducts = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No more Data!'),
          ),
        );
      }
    } catch (error) {
      setState(() {
        isLoadingMore = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load Data'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'My App Name',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              final route = MaterialPageRoute(
                builder: (context) => ProductsListPage(),
              );
              Navigator.push(context, route);
            },
            icon: Icon(
              Icons.search_outlined,
              size: 32,
            ),
          ),
        ],
      ),
      body: isLoadingProducts
          ? Center(
              child: CircularProgressIndicator(),
            )
          : products.isNotEmpty
              ? SafeArea(
                  child: Stack(
                    children: [
                      CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          SliverToBoxAdapter(
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: MySlideShow(imageUrls: slides),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 12,
                                ),
                                MyListHeader(
                                  title: 'Categories',
                                  isShowSeeMore: false,
                                ),
                                SizedBox(
                                  height:
                                      130, // Set a fixed height for horizontal ListView
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: categories.length,
                                    itemBuilder: (context, index) {
                                      final category = categories[index];
                                      return DatabaseCard(
                                        image: category.imageUrl,
                                        title: category.name,
                                        onTap: () {
                                          final route = MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductsListPage(
                                                    categoryId: category.id,
                                                  ));
                                          Navigator.push(context, route);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 12,
                                ),
                                MyListHeader(
                                  title: 'Most Viewed',
                                  isShowSeeMore: true,
                                ),
                                isLoadingProducts
                                    ? SizedBox(
                                        width: double.infinity,
                                        height: 100,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : Visibility(
                                        visible: products.isNotEmpty,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height:
                                                  200, // Set a fixed height for horizontal ListView
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: products.length,
                                                itemBuilder: (context, index) {
                                                  final product =
                                                      products[index];
                                                  return ProductCard(
                                                      width: 200,
                                                      id: product.id,
                                                      title: product.name,
                                                      price: product.price,
                                                      imageUrl:
                                                          product.imageUrl,
                                                      onTap: () {
                                                        final route =
                                                            MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductDetailPage(
                                                            product: product,
                                                          ),
                                                        );
                                                        Navigator.push(
                                                            context, route);
                                                      });
                                                },
                                              ),
                                            ),
                                            Visibility(
                                              visible: isLoadingProductsError,
                                              child: Container(
                                                width: double.infinity,
                                                height: 50,
                                                child: Center(
                                                  child: Text(
                                                      'Error Loading Resources'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              children: [
                                // ========================= Start Slide Show Middle =========================
                                Visibility(
                                  visible: slidesMiddle.isNotEmpty,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 24),
                                      AspectRatio(
                                        aspectRatio: 40 / 10,
                                        child: MySlideShow(
                                          imageUrls: slidesMiddle,
                                          aspectRatio: 40 / 10,
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                    ],
                                  ),
                                ),
                                // ========================= End Slide Show Middle =========================
                              ],
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              children: const [
                                SizedBox(
                                  height: 12,
                                ),
                                MyListHeader(
                                  title: 'Latest Post',
                                  isShowSeeMore: false,
                                ),
                              ],
                            ),
                          ),
                          SliverPadding(
                            padding: EdgeInsets.all(0.0),
                            sliver: SliverGrid(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                childAspectRatio: 4 / 4,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                childCount: products.length,
                                (context, index) {
                                  final product = products[index];
                                  return ProductCard(
                                      width: 200,
                                      id: product.id,
                                      title: product.name,
                                      price: product.price,
                                      imageUrl: product.imageUrl,
                                      onTap: () {
                                        final route = MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailPage(
                                            product: product,
                                          ),
                                        );
                                        Navigator.push(context, route);
                                      });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (isLoadingMore)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              : Center(
                  child: Text('No Data'),
                ),
    );
  }
}
