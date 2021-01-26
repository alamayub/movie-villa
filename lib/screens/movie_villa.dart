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
      appBar: AppBar(),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Container(height: 150, color: Colors.green),
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
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => Card(
        elevation: 6,
        child: Container(
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
                          Icon(Icons.star),
                          SizedBox(width: 4),
                          Text('${movies[index].rating}')
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(width: 16),
              Container(
                height: 100,
                width: size.width - 156,
                color: Colors.yellow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.purple,
                      child: Text('${movies[index].title}', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18), maxLines: 2, overflow: TextOverflow.ellipsis),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      separatorBuilder: (context, index) => SizedBox(height: 20),
      itemCount: movies.length
    );
  }
}

/*
ListTile(
        title: Text('${movies[index].title}'),
        tileColor: Colors.green.withOpacity(.25),
      )
 */