import 'package:flutter/material.dart';

import 'horizontal_poster_item.dart';

class HorizontalPosterWidget extends StatelessWidget {
  const HorizontalPosterWidget(this.title,
      {super.key, required this.list, required this.onTrailerClick});
  final List<dynamic> list;
  final String title;
  final Function(String trailerId) onTrailerClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 8),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: list
                .map((e) => HorizontalPosterItem(
                      title: e['original_title'],
                      imageUrl: e['backdrop_path'],
                      onTrailerClick: () {
                        onTrailerClick(e['id'].toString());
                      },
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}
