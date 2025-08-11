// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class FavouriteEvent extends Equatable {
  const FavouriteEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavouriteEvent extends FavouriteEvent {}

class MarkFavouriteEvent extends FavouriteEvent {
  int id;
  MarkFavouriteEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class MarkCompleteEvent extends FavouriteEvent {
  int id;
  MarkCompleteEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class DeleteItemEvent extends FavouriteEvent {}
