import 'dart:convert';

import 'package:api_bloc/model/posts_model.dart';
import 'package:http/http.dart' as http;

class PostsRepository {
  Future<List<PostsModel>> fetchPosts() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/comments'),
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as List;
        final postList = body.map((e) {
          return PostsModel(
            postId: e['postId'],
            id: e['id'],
            name: e['name'],
            email: e['email'],
            body: e['body'],
          );
        }).toList();
        return postList;
      } else {
        throw Exception("Failed to load posts: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching posts: $e");
    }
  }
}
