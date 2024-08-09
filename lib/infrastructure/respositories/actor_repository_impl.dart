import 'package:cinemapedia/domain/datasources/actores_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDataSource datasource;

  ActorRepositoryImpl({required this.datasource});

  @override
  Future<List<Actor>> gertActorsByMovie(String movieid) {
    return datasource.gertActorsByMovie(movieid);
  }
}
