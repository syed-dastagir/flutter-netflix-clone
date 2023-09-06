import 'package:flutter/material.dart';

class VerticalPosterItem extends StatelessWidget {
  const VerticalPosterItem(
      {super.key, required this.posterPath, required this.onClik});
  final String posterPath;
  final Function() onClik;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 150,
      padding: const EdgeInsets.only(left: 8),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(90))),
      child: InkWell(
        onTap: () {
          onClik();
        },
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.center,
          children: [
            Image.network(
              'https://image.tmdb.org/t/p/w300$posterPath',
            ),
            Image.asset('assets/play_large.png')
          ],
        ),
      ),
    );
  }
}
