import 'package:flutter/material.dart';

class Genre {
  final IconData iconData;
  final String title;

  Genre({ this.iconData, this.title });
}

List<Genre> genres = [
  Genre(iconData: Icons.attractions, title: 'Action'),
  Genre(iconData: Icons.science_rounded, title: 'Sci-fi'),
  Genre(iconData: Icons.anchor_rounded, title: 'Horror'),
  Genre(iconData: Icons.thirteen_mp, title: 'Thriller')
];
