import 'package:flutter/material.dart';
import 'http_service.dart';
import 'post_model.dart';
import 'update_post.dart';

class PostDetail extends StatefulWidget {
  final Post post;
  final int iCount;

  PostDetail({Key? key, required this.post, required this.iCount}) : super(key: key);

  @override
  State<PostDetail> createState() => _PostDetailState();
  
}

class _PostDetailState extends State<PostDetail> {
  final HttpService httpService = HttpService();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      title: Text('Titulo'),
                      subtitle: Text(widget.post.title),
                    ),
                    ListTile(
                      title: Text('ID'),
                      subtitle: Text('${widget.post.id}'),
                    ),
                    ListTile(
                      title: Text('Body'),
                      subtitle: Text(widget.post.body),
                    ),
                    ListTile(
                      title: Text('ID do usuário'),
                      subtitle: Text('${widget.post.userId}'),
                    ),
                    ListTile(
                      title: Text('Posição na lista'),
                      subtitle: Text('${widget.iCount}'),
                    ),
                    ElevatedButton(
                      onPressed:  () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => UpdatePost(iCount: widget.iCount))
                      ), 
                      child: Text('Editar')
                    )
                  ],
                )
              )
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            httpService.deletePosts(widget.iCount);
            Navigator.pop(context);
          });
        },
        child: Icon(Icons.delete_outline),
      )
    );
  }
}