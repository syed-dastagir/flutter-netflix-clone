import 'package:flutter/material.dart';

import 'vertical_poster_item.dart';

class VerticalPostersWidget extends StatelessWidget {
  const VerticalPostersWidget(this.title,
      {super.key, required this.list, required this.onItemClick});
  final List<dynamic> list;
  final String title;
  final Function(String id) onItemClick;

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
                .map((e) => VerticalPosterItem(
                      posterPath: e['poster_path'],
                      onClik: () {
                        onItemClick(e['id'].toString());
                      },
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}
