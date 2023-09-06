import 'package:flutter/material.dart';

class HorizontalPosterItem extends StatelessWidget {
  const HorizontalPosterItem(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.onTrailerClick});
  final String imageUrl;
  final String title;
  final Function() onTrailerClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTrailerClick();
      },
      child: Container(
        height: 150,
        width: 300,
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
                    Color.fromARGB(68, 113, 113, 113)
                  ])),
              child: Text(
                title,
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
