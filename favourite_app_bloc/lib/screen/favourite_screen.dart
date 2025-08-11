import 'package:favourite_app_bloc/bloc/favourite/favourite_bloc.dart';
import 'package:favourite_app_bloc/bloc/favourite/favourite_event.dart';
import 'package:favourite_app_bloc/bloc/favourite/favourite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    context.read<FavouriteBloc>().add(LoadFavouriteEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite Items List"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<FavouriteBloc>().add(DeleteItemEvent());
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: BlocBuilder<FavouriteBloc, FavouriteState>(
        builder: (context, state) {
          if (state.status == ListState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.status == ListState.Error) {
            return Text("Something Went Wrong");
          } else {
            return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: state.favouriteItems[index].isCompleted,
                    onChanged: (value) {
                      context.read<FavouriteBloc>().add(
                        MarkCompleteEvent(id: state.favouriteItems[index].id),
                      );
                    },
                  ),
                  title: Text(
                    state.favouriteItems[index].item,
                    style: TextStyle(
                      decoration: (state.favouriteItems[index].isCompleted)
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      context.read<FavouriteBloc>().add(
                        MarkFavouriteEvent(id: state.favouriteItems[index].id),
                      );
                    },
                    icon: Icon(
                      state.favouriteItems[index].isFavourite
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 20);
              },
              itemCount: state.favouriteItems.length,
            );
          }
        },
      ),
    );
  }
}
