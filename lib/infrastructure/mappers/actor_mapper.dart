import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:flutter/material.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
      character: cast.character,
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.baumandblume.com%2Ftestimonial-item%2Ftestimonial-01%2Fno-image-icon-md%2F&psig=AOvVaw2ppXl45hfvGNlP4qL-Lio_&ust=1722995118185000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCKjX2ZOf34cDFQAAAAAdAAAAABAT');
}
