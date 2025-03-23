import 'package:flutter/material.dart';
import 'package:red_cross_news_app/pages/settings/settings_page.dart';

class MyDrawer extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      "title": "ព័ត៌មានថ្មីៗ",
      "image":
          "https://redcross.kampu.solutions/assets/images/categories/1742573209KGfiDSdphl.jpeg"
    }, 
    {
      "title": "ការងារឥស្សរជនឆ្នើមថ្នាក់ជាតិ",
      "image":
          "https://redcross.kampu.solutions/assets/images/categories/17425733491q2IHftmgM.jpeg"
    },
    {
      "title": "យុវជន កក្រក",
      "image":
          "https://redcross.kampu.solutions/assets/images/categories/1742573428u66tabJmVe.jpeg"
    },
      {
      "title": "Website",
      "image":
          "https://redcross.kampu.solutions/assets/images/categories/1742575296QuHaF5ArdD.jpeg"
    },
    // {
    //   "title": "Sports",
    //   "image":
    //       "https://redcross.kampu.solutions/assets/images/categories/1740297855CzrvQ4WL7m.png"
    // },
    // {
    //   "title": "Entertainment & Lifestyle",
    //   "image":
    //       "https://redcross.kampu.solutions/assets/images/categories/1740297846mtf4p5qh5f.png"
    // },
    // {
    //   "title": "Health & Fitness",
    //   "image":
    //       "https://redcross.kampu.solutions/assets/images/categories/1740298074HeCPtLmIyk.png"
    // },
    // {
    //   "title": "Science & Environment",
    //   "image":
    //       "https://redcross.kampu.solutions/assets/images/categories/1740298149S8dSEeemN9.png"
    // },
    // {
    //   "title": "Education & Career",
    //   "image":
    //       "https://redcross.kampu.solutions/assets/images/categories/1740298197P3GLapzlB0.png"
    // },
    // {
    //   "title": "Crime & Security",
    //   "image":
    //       "https://redcross.kampu.solutions/assets/images/categories/1740298423rz0dhSgx2p.png"
    // },
    // {
    //   "title": "Opinion & Editorials",
    //   "image":
    //       "https://redcross.kampu.solutions/assets/images/categories/1740298471CKzhKsWak2.png"
    // }
  ];
  final List<Map<String, dynamic>> socialLinks = [
    {
      "title": "Facebook",
      "image":
          "https://redcross.kampu.solutions/assets/images/social_media/facebook.jpeg"
    },
    {
      "title": "Telegram",
      "image":
          "https://redcross.kampu.solutions/assets/images/social_media/telegram.jpeg"
    },
    {
      "title": "Tiktok",
      "image":
          "https://redcross.kampu.solutions/assets/images/social_media/tiktok.jpeg"
    },
    {
      "title": "E-Learning",
      "image":
          "https://redcross.kampu.solutions/assets/images/social_media/elearning.jpeg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Top Section: Logo and App Name
            // SizedBox(height: 20),

            Theme(
              data: Theme.of(context).copyWith(
                dividerTheme: const DividerThemeData(color: Colors.transparent),
              ),
              child: DrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).colorScheme.primary),
                child: Container(
                  width: double.infinity, // Ensure it spans the full width
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/assets/icons/logo.png',
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'CRC News',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 4),
            //   decoration: BoxDecoration(
            //     border: Border(
            //       top: BorderSide(
            //         color: Theme.of(context)
            //             .colorScheme
            //             .primary, // Set your desired color here
            //         width: 0.5, // Set the border width
            //       ),
            //       bottom: BorderSide(
            //         color: Theme.of(context)
            //             .colorScheme
            //             .primary, // Set your desired color here
            //         width: 0.5, // Set the border width
            //       ),
            //     ),
            //   ),
            //   child: ListTile(
            //     leading: Image.network(
            //       'https://redcross.kampu.solutions/assets/sponsor.png',
            //       width: 45,
            //       height: 45,
            //     ),
            //     title: Align(
            //       alignment: Alignment
            //           .centerLeft, // Ensures text stays aligned with the leading
            //       child: Text('Donate'),
            //     ),
            //     onTap: () {
            //       final route = MaterialPageRoute(
            //         builder: (context) => DonatePage(),
            //       );
            //       Navigator.push(context, route);
            //     },
            //   ),
            // ),

            // Middle Section: Category List
            Expanded(
              child: ListView(
                  padding: EdgeInsets.only(
                      bottom: 0, top: 10), // Remove default padding
                  children: [
                    ...categories
                        .map(
                          (category) => ListTile(
                            leading: Image.network(category["image"],
                                width: 45, height: 45),
                            title: Text(category["title"]),
                            onTap: () {},
                          ),
                        )
                        .toList(),
                    Container(
                      padding: EdgeInsets.only(bottom: 4),
                      child: ListTile(
                        leading: SizedBox(
                          width: 45,
                          child: Image.network(
                              'https://redcross.kampu.solutions/assets/images/social_media/youtube.jpeg',
                              width: 45,
                              height: 45),
                        ),
                        title: Align(
                          alignment: Alignment
                              .centerLeft, // Ensures text stays aligned with the leading
                          child: Text('Channel CRC'),
                        ),
                        onTap: () {
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 4),
                      child: ListTile(
                        leading: SizedBox(
                          width: 45,
                          child: Image.network(
                              'https://redcross.kampu.solutions/assets/images/social_media/x.jpeg',
                              width: 45,
                              height: 45),
                        ),
                        title: Align(
                          alignment: Alignment
                              .centerLeft, // Ensures text stays aligned with the leading
                          child: Text('X(Twitter)'),
                        ),
                        onTap: () {
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 4),
                      child: ListTile(
                        leading: SizedBox(
                          width: 45,
                          child: Icon(
                            Icons.settings,
                            size: 40,
                          ),
                        ),
                        title: Align(
                          alignment: Alignment
                              .centerLeft, // Ensures text stays aligned with the leading
                          child: Text('Settings & Contact'),
                        ),
                        onTap: () {
                          final route = MaterialPageRoute(
                            builder: (context) => SettingsPage(),
                          );
                          Navigator.push(context, route);
                        },
                      ),
                    ),
                  ]),
            ),

            // Bottom Section: Social Links (Row with Wrapping)
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .primary, // Set your desired color here
                    width: 0.5, // Set the border width
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: GridView.builder(
                padding: EdgeInsets.zero, // Remove default padding
                shrinkWrap:
                    true, // Prevents grid from taking up all vertical space
                physics:
                    NeverScrollableScrollPhysics(), // Disable scrolling inside GridView
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 4 columns
                ),
                itemCount: socialLinks.length, // Number of items in the grid
                itemBuilder: (context, index) {
                  final social = socialLinks[index];
                  return GestureDetector(
                    onTap: () {
                      // Handle social link tap
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(social["image"], width: 44, height: 44),
                        SizedBox(height: 4),
                        Text(social["title"], style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
