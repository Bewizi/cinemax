import 'package:cinemax/core/data/api.dart';
import 'package:cinemax/features/Explore/domain/entities/movie_entity.dart';

class MovieModels extends MovieEntity {
  const MovieModels({
    super.id,
    super.title,
    super.description,
    super.releaseYear,
    super.rating,
    super.image,
    super.price,
    super.movieDuration,
    super.genre,
    super.venue,
    super.tags,
  });

  factory MovieModels.fromJson(Map<String, dynamic> json) {
    var imageUrl =
        json['image_url'] as String? ?? json['image'] as String? ?? '';
    if (imageUrl.isNotEmpty && !imageUrl.startsWith('http')) {
      // If it's a relative path from the 'image' field, Laravel usually expects /storage/ prefix
      if (json.containsKey('image') && !imageUrl.startsWith('storage/')) {
        imageUrl = '${Api.rootUrl}storage/$imageUrl';
      } else {
        imageUrl = '${Api.rootUrl}$imageUrl';
      }
    }

    return MovieModels(
      id: json['id'] as String?,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      releaseYear: json['release_year'] as String? ?? '',
      rating: json['rating'] as String? ?? '',
      image: imageUrl,
      price: double.tryParse(json['price']?.toString() ?? '0.0') ?? 0.0,
      movieDuration: json['movie_duration'] as String? ?? '',
      genre:
          (json['genre'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          [],
      venue: json['venue'] as String? ?? '',
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'release_year': releaseYear,
      'rating': rating,
      'image': image,
      'price': price,
      'movie_duration': movieDuration,
      'genre': genre,
      'venue': venue,
      'tags': tags,
    };
  }

  MovieEntity toEntity() => MovieEntity(
    id: id,
    title: title,
    description: description,
    releaseYear: releaseYear,
    rating: rating,
    image: image,
    price: price,
    movieDuration: movieDuration,
    genre: genre,
    venue: venue,
    tags: tags,
  );
}
