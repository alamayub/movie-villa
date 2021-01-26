import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_villa/models/genre.dart';
import 'package:movie_villa/models/movie.dart';

class ViewDetail extends StatefulWidget {
  final Movie movie;
  ViewDetail({ this.movie });
  @override
  _ViewDetailState createState() => _ViewDetailState();
}

class _ViewDetailState extends State<ViewDetail> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        titleSpacing: 0,
        leading: FlatButton(
          shape: CircleBorder(),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
          child: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
        ),
        title: Text('${widget.movie.title}', style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        color: Colors.white,
        height: size.height,
        width: size.width,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 16),
              height: size.height / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage('https://image.tmdb.org/t/p/original/${widget.movie.poster}'),
                  fit: BoxFit.cover,
                )
              ),
              clipBehavior: Clip.antiAlias,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text('${widget.movie.title}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            ),
            RatingBar(
              initialRating: widget.movie.rating,
              minRating: 1,
              maxRating: 10,
              direction: Axis.horizontal,
              itemCount: 10,
              itemSize: 18,
              allowHalfRating: true,
              itemPadding: EdgeInsets.symmetric(horizontal: 4),
              ratingWidget: RatingWidget(
                full: Icon(Icons.star),
                half: Icon(Icons.star_half),
                empty: Icon(Icons.star_border)
              ),
              onRatingUpdate: (val) => print('$val'),
            ),
            SizedBox(height: 8),
            Text('Release Date :- ${widget.movie.releaseDate}'),
            SizedBox(height: 8),
            Text('Rating : ${widget.movie.rating} / 10'),
            SizedBox(height: 8),
            Text('Popularity : ${widget.movie.popularity}'),
            SizedBox(height: 8),
            Text('Total Vote : ${widget.movie.vote}'),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text('Synopsis : ${widget.movie.overview}', style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(.5))),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 12),
              child: Text('Top Genres', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: genres.map((i) => Container(
                width: (size.width - 56 ) / 4,
                height: (size.width - 56 ) / 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(i.iconData),
                    SizedBox(height: 3),
                    Text('${i.title}', style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
              )).toList(),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar (
        elevation: 0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          color: Colors.white,
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blueGrey.withOpacity(.15)
                ),
                child: Row(
                  children: [
                    FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minWidth: 0,
                      height: 0,
                      padding: EdgeInsets.all(10),
                      onPressed: () {
                        print('liked');
                      },
                      child: Icon(Icons.favorite_outlined, color: Colors.pink),
                      color: Colors.transparent,
                      shape: CircleBorder(),
                    ),
                    SizedBox(width: 4),
                    Text('${widget.movie.vote}', style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
                ),
                color: Colors.blueGrey,
                onPressed: () => print('watch'),
                child: Text('WATCH NOW', style: TextStyle(fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
