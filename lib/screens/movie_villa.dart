import 'package:flutter/material.dart';
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
    List<Movie> movies = data.movies;
    return ListView.separated(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => ListTile(
        title: Text('${movies[index].title}'),
        tileColor: Colors.green.withOpacity(.25),
      ),
      separatorBuilder: (context, index) => SizedBox(height: 20),
      itemCount: movies.length
    );
  }
}
