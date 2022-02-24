import 'package:flutter/material.dart';
import 'package:flutter_apirest/post_detail.dart';
import 'http_service.dart';
import 'post_model.dart';

class deletePost extends StatefulWidget {

  // final Post post;

  const deletePost({ Key? key,  }) : super(key: key);

  @override
  _deletePostState createState() => _deletePostState();
}

class _deletePostState extends State<deletePost> {
  late Future<Post> _futurePost;
  final HttpService httpService = HttpService();

  @override
  void initState() {
    super.initState();
    _futurePost = httpService.getPost();
  }
    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deletar Dados',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Deletar Dados'),
        ),
        body: Center(
          child: FutureBuilder<Post>(
            future: _futurePost,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(snapshot.data?.title ?? 'Deleted'),
                      ElevatedButton(
                        child: const Text('Delete Data'),
                        onPressed:(){
                          Navigator.pop(context);
                        } 
                        //  () {
                        //   setState(() {
                        //     _futurePost =
                        //         httpService.deletePosts(widget.post.id);
                        //   });
                        // },
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}