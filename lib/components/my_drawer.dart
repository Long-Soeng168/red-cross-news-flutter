import 'package:flutter/material.dart';
import 'package:red_cross_news_app/pages/settings/settings_page.dart';

class MyDrawer extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      "title": "World News",
      "image":
          "https://redcross.kampu.solutions/assets/images/categories/1740297417WkRwepN4DS.png"
    },
    {
      "title": "National News",
      "image":
          "https://redcross.kampu.solutions/assets/images/categories/1740297406UPGvdsiBLz.png"
    },
    {
      "title": "Business & Finance",
      "image":
          "https://redcross.kampu.solutions/assets/images/categories/1740297453h40G1Rggeg.png"
    },
    {
      "title": "Technology",
      "image":
          "https://redcross.kampu.solutions/assets/images/categories/17402975869XWEMgI5Xt.png"
    },
    {
      "title": "Sports",
      "image":
          "https://redcross.kampu.solutions/assets/images/categories/1740297855CzrvQ4WL7m.png"
    },
    {
      "title": "Entertainment & Lifestyle",
      "image":
          "https://redcross.kampu.solutions/assets/images/categories/1740297846mtf4p5qh5f.png"
    },
    {
      "title": "Health & Fitness",
      "image":
          "https://redcross.kampu.solutions/assets/images/categories/1740298074HeCPtLmIyk.png"
    },
    {
      "title": "Science & Environment",
      "image":
          "https://redcross.kampu.solutions/assets/images/categories/1740298149S8dSEeemN9.png"
    },
    {
      "title": "Education & Career",
      "image":
          "https://redcross.kampu.solutions/assets/images/categories/1740298197P3GLapzlB0.png"
    },
    {
      "title": "Crime & Security",
      "image":
          "https://redcross.kampu.solutions/assets/images/categories/1740298423rz0dhSgx2p.png"
    },
    {
      "title": "Opinion & Editorials",
      "image":
          "https://redcross.kampu.solutions/assets/images/categories/1740298471CKzhKsWak2.png"
    }
  ];
  final List<Map<String, dynamic>> socialLinks = [
    {
      "title": "Facebook",
      "image":
          "https://redcross.kampu.solutions/assets/images/links/facebook.png"
    },
    {
      "title": "Telegram",
      "image":
          "https://redcross.kampu.solutions/assets/images/links/telegram.png"
    },
    {
      "title": "YouTube",
      "image":
          "https://redcross.kampu.solutions/assets/images/links/youtube.png"
    },
    {
      "title": "TikTok",
      "image":
          "https://redcross.kampu.solutions/assets/images/links/1740301121BPKqsYO30R.png"
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
            Container(
              padding: EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .primary, // Set your desired color here
                    width: 0.5, // Set the border width
                  ),
                ),
              ),
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

            // Middle Section: Category List
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(
                    bottom: 20, top: 10), // Remove default padding
                children: categories
                    .map(
                      (category) => ListTile(
                        leading: Image.network(category["image"],
                            width: 45, height: 45),
                        title: Text(category["title"]),
                        onTap: () {},
                      ),
                    )
                    .toList(),
              ),
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
                  crossAxisSpacing: 8, // Horizontal spacing between items
                  mainAxisSpacing: 8, // Vertical spacing between items
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
                        Image.network(social["image"], width: 45, height: 45),
                        SizedBox(height: 4),
                        Text(social["title"], style: TextStyle(fontSize: 12)),
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
