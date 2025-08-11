import 'package:bloc/bloc.dart';
import 'package:favourite_app_bloc/bloc/favourite/favourite_event.dart';
import 'package:favourite_app_bloc/bloc/favourite/favourite_state.dart';
import 'package:favourite_app_bloc/data/model/favourite_item_model.dart';
import 'package:favourite_app_bloc/data/repo/favourite_repo.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteRepo favouriteRepo;
  FavouriteBloc(this.favouriteRepo) : super(FavouriteState()) {
    on<MarkFavouriteEvent>(_markFavouriteEvent);
    on<MarkCompleteEvent>(_markCompleteEvent);
    on<LoadFavouriteEvent>(_loadFavouriteEvent);
    on<DeleteItemEvent>(_deleteItemEvent);
  }

  void _markFavouriteEvent(
    MarkFavouriteEvent event,
    Emitter<FavouriteState> emit,
  ) {
    final updatedItems = List<FavouriteItemModel>.from(state.favouriteItems);

    final index = updatedItems.indexWhere((data) => data.id == event.id);
    if (index != -1) {
      updatedItems[index] = updatedItems[index].copyWith(
        isFavourite: !updatedItems[index].isFavourite,
      );
    }

    emit(state.copyWith(updatedItems, ListState.Success));
  }

  void _markCompleteEvent(
    MarkCompleteEvent event,
    Emitter<FavouriteState> emit,
  ) {
    final updatedItems = List<FavouriteItemModel>.from(state.favouriteItems);

    final index = updatedItems.indexWhere((data) => data.id == event.id);
    if (index != -1) {
      updatedItems[index] = updatedItems[index].copyWith(
        isCompleted: !updatedItems[index].isCompleted,
      );
    }

    emit(state.copyWith(updatedItems, ListState.Success));
  }

  void _loadFavouriteEvent(
    LoadFavouriteEvent event,
    Emitter<FavouriteState> emit,
  ) async {
    List<FavouriteItemModel> items = await favouriteRepo.fetchFavourites();
    emit(state.copyWith(items, ListState.Success));
  }

  void _deleteItemEvent(DeleteItemEvent event, Emitter<FavouriteState> emit) {
    final updatedItems = List<FavouriteItemModel>.from(state.favouriteItems);
    updatedItems.removeWhere((element) => element.isCompleted == true);

    emit(state.copyWith(updatedItems, ListState.Success));
  }
}
