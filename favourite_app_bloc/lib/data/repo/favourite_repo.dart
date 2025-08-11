import 'package:favourite_app_bloc/data/model/favourite_item_model.dart';

class FavouriteRepo {
  Future<List<FavouriteItemModel>> fetchFavourites() async {
    await Future.delayed(Duration(seconds: 3));
    return List.generate(
      10,
      (index) => FavouriteItemModel(id: index, item: "Item $index"),
    );
  }
}
