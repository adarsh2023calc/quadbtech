import 'package:flutter/material.dart';
import '../models/movies.dart';

class MovieTitle extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MovieTitle({
    Key? key,
    required this.movie,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Thumbnail
            movie.imageUrl.isNotEmpty
                ? ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                    child: Image.network(
                      movie.imageUrl,
                      height: 100,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    height: 100,
                    width: 80,
                    color: Colors.grey,
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
            const SizedBox(width: 10),
            // Movie Title and Summary
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _stripHtmlTags(movie.summary),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Utility function to strip HTML tags from the movie summary
  String _stripHtmlTags(String htmlText) {
    final regex = RegExp(r'<[^>]*>');
    return htmlText.replaceAll(regex, '').trim();
  }
}
