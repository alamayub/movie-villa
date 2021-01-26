import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_villa/bloc/get_movies_bloc.dart';
import 'package:movie_villa/models/movie.dart';
import 'package:movie_villa/models/movie_response.dart';

class MovieVilla extends StatefulWidget {
  @override
  _MovieVillaState createState() => _MovieVillaState();
}

class _MovieVillaState extends State<MovieVilla> {

  @override
  void initState() {
    moviesBloc.getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
        actions: [
          Icon(Icons.search_rounded, color: Colors.black),
          SizedBox(width: 16),
          Icon(Icons.apps_rounded, color: Colors.black),
          SizedBox(width: 16)
        ],
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text('Latest\nMovies', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
            StreamBuilder(
              stream: moviesBloc.subject.stream,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return _buildAllMovies(snapshot.data);
                } else if (snapshot.hasError) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: Center(child: Text('Something happened')),
                  );
                // ignore: unrelated_type_equality_checks
                } else if(snapshot.connectionState == null){
                  return Container(
                    child: Center(
                      child: Text('You device has no internet connection'),
                    ),
                  );
                } else {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }
            )
          ],
        ),
      ),
    );
  }

  _buildAllMovies(MovieResponse data) {
    Size size = MediaQuery.of(context).size;
    List<Movie> movies = data.movies;
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          print('${movies[index]}');
        },
        child: Card(
          elevation: 6,
          shadowColor: Colors.grey.withOpacity(.25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16)
            ),
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    Container(
                      height: 120,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.25),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage('https://image.tmdb.org/t/p/original/${movies[index].poster}'),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      right: -10,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.star, size: 15),
                            SizedBox(width: 4),
                            Text('${movies[index].rating}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(width: 16),
                Container(
                  height: 120,
                  width: size.width - 178,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${movies[index].title}', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18), maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text('${movies[index].overview}', style: TextStyle(color: Colors.grey.withOpacity(.75), fontSize: 15),  maxLines: 3, overflow: TextOverflow.ellipsis),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${movies[index].releaseDate}', style: TextStyle(fontWeight: FontWeight.w500),),
                          Row(
                            children: [
                              Icon(Icons.thumb_up_rounded, size: 15),
                              SizedBox(width: 4),
                              Text('${movies[index].vote}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      separatorBuilder: (context, index) => SizedBox(height: 20),
      itemCount: movies.length
    );
  }
}

