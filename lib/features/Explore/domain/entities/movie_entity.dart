import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  const MovieEntity({
    this.id,
    this.title,
    this.description,
    this.releaseYear,
    this.rating,
    this.image,
    this.price,
    this.movieDuration,
    this.genre,
    this.tags,
    this.venue,
  });

  final String? id;
  final String? title;
  final String? description;
  final String? releaseYear;
  final String? rating;
  final String? image;
  final double? price;
  final String? movieDuration;
  final List<String>? genre;
  final String? venue;
  final List<String>? tags;

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    releaseYear,
    rating,
    image,
    price,
    movieDuration,
    genre,
    venue,
    tags,
  ];
}
