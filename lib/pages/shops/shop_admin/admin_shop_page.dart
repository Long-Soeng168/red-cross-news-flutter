// ignore_for_file: prefer_const_constructors

import 'package:red_cross_news_app/components/cards/detail_list_card.dart';
import 'package:red_cross_news_app/components/cards/product_card.dart';
import 'package:red_cross_news_app/components/cards/shop_tile_card.dart';
import 'package:red_cross_news_app/components/my_slide_show.dart';
import 'package:red_cross_news_app/components/my_tab_button.dart';
import 'package:red_cross_news_app/models/product.dart';
import 'package:red_cross_news_app/models/shop.dart';
import 'package:red_cross_news_app/pages/shops/shop_admin/admin_product_detail_page.dart';
import 'package:red_cross_news_app/pages/shops/shop_admin/product_create_page.dart';
import 'package:red_cross_news_app/pages/shops/shop_admin/shop_edit_page.dart';
import 'package:red_cross_news_app/services/product_service.dart';
import 'package:flutter/material.dart';

class AdminShopPage extends StatefulWidget {
  const AdminShopPage({super.key, required this.shop});
  final Shop shop;
  @override
  State<AdminShopPage> createState() => _AdminShopPageState();
}

class _AdminShopPageState extends State<AdminShopPage> {
  int _selectedTabIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getProducts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !isLoadingMore) {
        loadMoreProducts();
      }
    });
    print(widget.shop.id);
  }

  List<Product> products = [];
  bool isLoadingProducts = true;
  bool isLoadingProductsError = false;
  bool hasMoreProducts = true;
  bool isLoadingMore = false;
  int currentPage = 1;

  final ScrollController _scrollController = ScrollController();

  Future<void> getProducts() async {
    try {
      final fetchedProducts =
          await ProductService.fetchProducts(page: 1, shopId: widget.shop.id);
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.shop.name,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShopEditPage(
                          shop: widget.shop,
                        )),
              );
            },
            icon: Icon(
              Icons.edit,
              size: 32,
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 70.0, // Custom height
        width: 70.0, // Custom width
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductCreatePage(
                        shop: widget.shop,
                      )),
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(100), // Large radius for full rounding
          ),
          child: Icon(
            Icons.add,
            size: 35,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ========================= Start Slide Show =========================
            AspectRatio(
              aspectRatio: 16 / 9,
              child: MySlideShow(imageUrls: [
                widget.shop.bannerUrl,
              ]),
            ),
            // ========================= End Slide Show =========================
            ShopTileCard(
              imageUrl: widget.shop.logoUrl,
              address: widget.shop.address,
              name: widget.shop.name,
              phone: widget.shop.phone,
              isShowChevron: false,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                // Row(
                //   children: [
                //     SizedBox(
                //       width: 8,
                //     ),
                //     Row(
                //       children: [
                //         IconButton(
                //           onPressed: () {},
                //           icon: Icon(
                //             Icons.thumb_up_outlined,
                //             size: 24,
                //             color: Colors.grey,
                //           ),
                //         ),
                //         Text(
                //           '2139',
                //           maxLines: 1,
                //           overflow: TextOverflow.ellipsis,
                //           style: TextStyle(
                //             fontSize: 16,
                //             color: Colors.grey,
                //           ),
                //         ),
                //       ],
                //     ),
                //     Container(
                //       width: 1,
                //       height: 14,
                //       margin: EdgeInsets.only(left: 18, right: 8),
                //       color: Colors.grey,
                //     ),
                //     Row(
                //       children: [
                //         IconButton(
                //           onPressed: () {},
                //           icon: Icon(
                //             Icons.thumb_down_outlined,
                //             size: 24,
                //             color: Colors.grey,
                //           ),
                //         ),
                //         Text(
                //           '138',
                //           maxLines: 1,
                //           overflow: TextOverflow.ellipsis,
                //           style: TextStyle(
                //             fontSize: 16,
                //             color: Colors.grey,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ],
            ),

            // ========================= Start Tab =========================
            Row(
              children: [
                MyTabButton(
                  title: 'Products',
                  isSelected: _selectedTabIndex == 0,
                  onTap: () {
                    setState(() {
                      _selectedTabIndex = 0;
                    });
                  },
                ),
                MyTabButton(
                  title: 'About Shop',
                  isSelected: _selectedTabIndex == 1,
                  onTap: () {
                    setState(() {
                      _selectedTabIndex = 1;
                    });
                  },
                ),
              ],
            ),
            // ========================= End Tab =========================

            // ========================= Start Product =========================
            if (_selectedTabIndex == 0)
              Column(
                children: [
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
                              GridView.builder(
                                shrinkWrap:
                                    true, // Important: Let GridView take up only needed space
                                physics:
                                    NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Number of columns
                                  childAspectRatio:
                                      0.72, // Aspect ratio of the grid items
                                ),
                                itemCount: products
                                    .length, // Total number of filtered items
                                itemBuilder: (context, index) {
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
                                              AdminProductDetailPage(
                                            product: product,
                                            shop: widget.shop,
                                          ),
                                        );
                                        Navigator.push(context, route);
                                      });
                                }, // Use your PublicationCard widget
                              ),
                            ],
                          ),
                        ),
                  Visibility(
                    visible: isLoadingProductsError,
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Center(
                        child: Text('Error Loading Resources'),
                      ),
                    ),
                  ),
                ],
              ),
            // ========================= End Product =========================

            // ========================= Start Detail =========================
            if (_selectedTabIndex == 1)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.0),
                    Column(children: [
                      // Start Detail
                      DetailListCard(
                        keyword: 'Contact',
                        value: widget.shop.phone,
                      ),
                      DetailListCard(
                        keyword: 'Address',
                        value: widget.shop.address,
                      ),
                      // End Detail

                      ListTile(
                        contentPadding: EdgeInsets.all(2),
                        title: Text(
                          'Description',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(widget.shop.description),
                      ),
                    ])
                  ],
                ),
              ),
            // ========================= End Detail =========================
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
