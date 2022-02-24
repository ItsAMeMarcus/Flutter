import 'dart:convert';
import 'package:http/http.dart' as http;
import 'post_model.dart';

class HttpService {
  var postsURL = Uri.parse("http://192.168.42.88:8000/teste");
  //toda vez que o pc desconectar da internet, ele vai gerar um novo ip. Caso isso aconteça, veja qual o novo ip e coloque ele aqui
  

  Future<List<Post>> getPosts() async {
    var res = await http.get(postsURL);
    
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Post> posts = body
        .map(
          (dynamic item) => Post.fromJson(item),
        )
        .toList();
        
      return posts;
    }
    else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<Post> getPost() async {
    var res = await http.get(Uri.parse("http://192.168.42.88:8000/teste"));
    
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);

      Post test = Post.fromJson(body.last);
    
      return test;
    }
    else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<void> deletePosts(int id) async {
    final res = await http.delete(Uri.parse("http://192.168.42.88:8000/teste/$id"),
    headers: <String, String>{
      'Content-Type' : 'application/json; charset=UTF-8'
    });

    if (res.statusCode == 200) {
    }
    else {
      throw Exception("Unable to delete posts.");
    }
  }

  Future<Post> createPosts(int userId, int id, String title, String body) async {

    
    final res = await http.post(postsURL,
      headers: <String,String>{
        'Content-Type' : 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId' : userId,
        'id' : id,
        'title' : title,
        'body' : body,
      })
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      final body = jsonDecode(res.body);

      Post test = Post.fromJson(body.last);
      
      return test;
    }
    else {
      throw Exception("Falhou em criar posts.");
    }
  }
  
  Future<Post> updatePosts(int userId, int id, String title, String body, int iD) async {

    
    final res = await http.put(Uri.parse("http://192.168.42.88:8000/teste/$iD"),
      headers: <String,String>{
        'Content-Type' : 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId' : userId,
        'id' : id,
        'title' : title,
        'body' : body,
      })
    );

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);

      Post test = Post.fromJson(body.last);
      
      return test;
    }
    else {
      throw Exception("Falhou em criar posts.");
    }
  }
  
}
