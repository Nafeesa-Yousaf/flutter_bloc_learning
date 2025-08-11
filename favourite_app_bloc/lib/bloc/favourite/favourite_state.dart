import 'package:equatable/equatable.dart';
import 'package:favourite_app_bloc/data/model/favourite_item_model.dart';

enum ListState { Loading, Success, Error }

class FavouriteState extends Equatable {
  List<FavouriteItemModel> favouriteItems;
  ListState status;
  FavouriteState({
    this.favouriteItems = const [],
    this.status = ListState.Loading,
  });

  FavouriteState copyWith(List<FavouriteItemModel>? items, ListState? status) {
    return FavouriteState(
      favouriteItems: items ?? this.favouriteItems,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [favouriteItems, status];
}
