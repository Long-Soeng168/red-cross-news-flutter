import 'package:red_cross_news_app/components/error_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    this.id = 0,
    this.limitLine = 4,
    this.title = '',
    this.price = '',
    this.imageUrl = '',
    this.onTap,
    this.aspectRatio = 16 / 9,
    this.width = 200,
    this.isShowLink = false,
  });

  final int id;
  final int limitLine;
  final String title;
  final String price;
  final String imageUrl;
  final void Function()? onTap;
  final double aspectRatio;
  final double width;
  final bool isShowLink;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          width: width,
          height: double.infinity,
          // padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.transparent,
            // border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: AspectRatio(
                    aspectRatio: aspectRatio,
                    child: Image.network(
                      imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const ErrorImage(size: 50);
                      },
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: limitLine,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16, // Set font size to 12
                              height: 1.75,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      if (isShowLink)
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Space between children
                          children: [
                            // Left side: Image and Text for 'Facebook'
                            GestureDetector(
                              onTap: () async {
                                final Uri url = Uri.parse(
                                    'https://www.facebook.com/crcnhq');
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url,
                                      mode: LaunchMode.externalApplication);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: Row(
                                children: [
                                  Image.network(
                                    'https://redcross.kampu.solutions/assets/images/links/facebook.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  const SizedBox(
                                      width:
                                          8), // Add space between the image and text
                                  const Text(
                                    'Facebook',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Text(
                              '06-Mar-2025',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),

                            // Right side: 'Read More' text
                            Container(
                              padding: EdgeInsets.only(left: 2, right: 4),
                              child: const Text(
                                'Read More >',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors
                                      .blueAccent, // Optional: blue accent color
                                ),
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
