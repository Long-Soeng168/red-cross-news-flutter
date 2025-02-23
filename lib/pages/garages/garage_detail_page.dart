// ignore_for_file: prefer_const_constructors

import 'package:red_cross_news_app/components/cards/detail_list_card.dart';
import 'package:red_cross_news_app/components/cards/garage_post_card.dart';
import 'package:red_cross_news_app/components/cards/shop_tile_card.dart';
import 'package:red_cross_news_app/components/my_slide_show.dart';
import 'package:red_cross_news_app/components/my_tab_button.dart';
import 'package:red_cross_news_app/models/garage.dart';
import 'package:red_cross_news_app/models/garage_post.dart';
import 'package:red_cross_news_app/services/garage_service.dart';
import 'package:flutter/material.dart';

class GarageDetailPage extends StatefulWidget {
  const GarageDetailPage({super.key, required this.garage});

  final Garage garage;

  @override
  State<GarageDetailPage> createState() => _GarageDetailPageState();
}

class _GarageDetailPageState extends State<GarageDetailPage> {
  int _selectedTabIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getResource();
  }

  void getResource() {
    getGaragesPosts();
  }

  // final List<String> imageUrls = [
  //   'https://thnal.com/assets/images/images/thumb/1724644805cYik37Kni4.jpg',
  //   'https://thnal.com/assets/images/images/thumb/1724645207ijk4Luu0MV.jpg',
  // ];

  List<GaragePost> garagesPosts = [];
  bool isLoadingGaragesPosts = true;
  bool isLoadingGaragesPostsError = false;

  Future<void> getGaragesPosts() async {
    try {
      // Fetch garagesPosts outside of setState
      final fetchedGaragesPosts =
          await GarageService.fetchGaragesPosts(garageId: widget.garage.id);
      // Update the state
      setState(() {
        garagesPosts = fetchedGaragesPosts;
        isLoadingGaragesPosts = false;
      });
    } catch (error) {
      // Handle any errors that occur during the fetch
      setState(() {
        isLoadingGaragesPosts = false;
        isLoadingGaragesPostsError = true;
      });
      // You can also show an error message to the user
      print('Failed to load Garage Post: $error');
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
          widget.garage.name,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ========================= Start Images =========================
            // ========================= Start Slide Show =========================
            AspectRatio(
              aspectRatio: 16 / 9,
              child: MySlideShow(imageUrls: [
                widget.garage.bannerUrl,
              ]),
            ),
            // ========================= End Slide Show =========================
            ShopTileCard(
              isShowChevron: false,
              phone: widget.garage.phone,
              name: widget.garage.name,
              address: widget.garage.address,
              imageUrl: widget.garage.logoUrl,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Row(
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    // Row(
                    //   children: [
                    //     IconButton(
                    //       onPressed: () {},
                    //       icon: Icon(
                    //         Icons.thumb_up_outlined,
                    //         size: 24,
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //     Text(
                    //       '2139',
                    //       maxLines: 1,
                    //       overflow: TextOverflow.ellipsis,
                    //       style: TextStyle(
                    //         fontSize: 16,
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Container(
                    //   width: 1,
                    //   height: 14,
                    //   margin: EdgeInsets.only(left: 18, right: 8),
                    //   color: Colors.grey,
                    // ),
                    // Row(
                    //   children: [
                    //     IconButton(
                    //       onPressed: () {},
                    //       icon: Icon(
                    //         Icons.thumb_down_outlined,
                    //         size: 24,
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //     Text(
                    //       '138',
                    //       maxLines: 1,
                    //       overflow: TextOverflow.ellipsis,
                    //       style: TextStyle(
                    //         fontSize: 16,
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ],
            ),

            // ========================= Start Tab =========================
            Row(
              children: [
                MyTabButton(
                  title: 'Posts',
                  isSelected: _selectedTabIndex == 0,
                  onTap: () {
                    setState(() {
                      _selectedTabIndex = 0;
                    });
                  },
                ),
                MyTabButton(
                  title: 'About Garage',
                  isSelected: _selectedTabIndex == 1,
                  onTap: () {
                    setState(() {
                      _selectedTabIndex = 1;
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 8),
            // ========================= End Tab =========================

            // ========================= Start Product =========================
            if (_selectedTabIndex == 0)
              Column(
                children: [
                  isLoadingGaragesPosts
                      ? SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Visibility(
                          visible: garagesPosts.isNotEmpty,
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap:
                                    true, // Let ListView take only as much space as needed
                                physics:
                                    NeverScrollableScrollPhysics(), // Disable its own scrolling if not needed
                                itemCount: garagesPosts.length,
                                itemBuilder: (context, index) {
                                  final garagePost = garagesPosts[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 0), // Spacing between cards
                                    child: GaragePostCard(
                                      aspectRatio: 16 / 9,
                                      id: garagePost.id,
                                      title: garagePost.description,
                                      imageUrl: garagePost.imageUrl,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                  Visibility(
                    visible: isLoadingGaragesPostsError,
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
                        keyword: 'Expert',
                        value: widget.garage.expertName,
                      ),
                      DetailListCard(
                        keyword: 'Contact',
                        value: widget.garage.phone,
                      ),
                      DetailListCard(
                        keyword: 'Address',
                        value: widget.garage.address,
                      ),
                      // End Detail

                      ListTile(
                        contentPadding: EdgeInsets.all(2),
                        title: Text(
                          'Description',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(widget.garage.description),
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
