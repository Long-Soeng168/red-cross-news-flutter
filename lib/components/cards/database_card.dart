import 'package:flutter/material.dart';
import 'package:red_cross_news_app/components/error_image.dart';

class DatabaseCard extends StatelessWidget {
  const DatabaseCard(
      {super.key, required this.image, required this.title, this.onTap});

  final String image;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // color: Colors.amber,
        ),
        // margin: EdgeInsets.all(10),
        padding: const EdgeInsets.only(left: 4, right: 4, bottom: 4),
        child: Column(
          children: [
            // Product Image
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: AspectRatio(
                      aspectRatio: 1,
                      // child: Icon(Icons.favorite),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Image.network(
                          image,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const ErrorImage(size: 50);
                          },
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) {
                              return child;
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                // Product Name
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    // backgroundColor: Colors.amber,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
