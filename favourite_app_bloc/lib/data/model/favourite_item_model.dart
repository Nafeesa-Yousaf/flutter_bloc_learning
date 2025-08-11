import 'package:equatable/equatable.dart';

class FavouriteItemModel extends Equatable {
  int id;
  String item;
  bool isFavourite;
  bool isCompleted;

  FavouriteItemModel({
    required this.id,
    required this.item,
    this.isCompleted = false,
    this.isFavourite = false,
  });

  FavouriteItemModel copyWith({
    int? id,
    String? item,
    bool? isFavourite,
    bool? isCompleted,
  }) {
    return FavouriteItemModel(
      id: id ?? this.id,
      item: item ?? this.item,
      isFavourite: isFavourite ?? this.isFavourite,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, item, isCompleted, isFavourite];
}
