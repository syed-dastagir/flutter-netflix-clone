import 'package:flutter/material.dart';

class RecommendedMovies extends StatelessWidget {
  const RecommendedMovies(
      {super.key,
      required this.onRecommendedMovieClick,
      required this.imageUrl,
      required this.title});
  final Function() onRecommendedMovieClick;
  final String? imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onRecommendedMovieClick();
      },
      child: Container(
        padding: const EdgeInsets.only(left: 8),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(90))),
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.network(
                'https://image.tmdb.org/t/p/w500$imageUrl',
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.transparent,
                    Color.fromARGB(157, 77, 76, 76)
                  ])),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800),
              ),
            )
          ],
        ),
      ),
    );
  }
}
