class Movie {
  final bool adult;
  final int id;
  final double popularity;
  final String originalTitle;
  final String title;
  final String backPoster;
  final String poster;
  final String overview;
  final String releaseDate;
  final double rating;
  final int vote;

  Movie({ this.adult, this.id, this.popularity, this.originalTitle, this.title, this.backPoster, this.poster, this.overview, this.releaseDate, this.rating, this.vote });

  Movie.fromJson(Map<String, dynamic> json)
  : adult = json['adult'],
    id = json['id'],
    popularity = json['popularity'],
    originalTitle = json['original_title'],
    title = json['title'],
    backPoster = json['backdrop_path'],
    poster = json['poster_path'],
    overview = json['overview'],
    releaseDate = json['release_date'],
    rating = json['vote_average'].toDouble(),
    vote = json['vote_count'];
}