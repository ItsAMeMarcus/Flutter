import 'package:flutter/material.dart';
import 'package:flutter_apirest/post_detail.dart';
import 'package:flutter_apirest/posts.dart';
import 'http_service.dart';
import 'post_model.dart';

class UpdatePost extends StatefulWidget{
  int iCount;

  UpdatePost({Key? key,required this.iCount}) : super(key: key);

  @override
  State<UpdatePost> createState() => _UpdatePostState();
}

class _UpdatePostState extends State<UpdatePost> {
  Future<Post>? _futurePost;

  final TextEditingController _controllerUserID = TextEditingController();
  final TextEditingController _controllerID = TextEditingController();
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerBody = TextEditingController();

  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adicionar Data',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.green
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Editar Post'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futurePost == null) ? buildColumn() :  buildFutureBuilder(),
        ),
      )
    );
  }

  Column buildColumn(){
    return Column(
      children: <Widget>[
        TextField(
          controller: _controllerUserID,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'Coloque o userID'),
        ),
        TextField(
          controller: _controllerID,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'Coloque o ID'),
        ),
        TextField(
          controller: _controllerTitle,
          decoration: const InputDecoration(hintText: 'Coloque o Título'),
        ),
        TextField(
          controller: _controllerBody,
          decoration: const InputDecoration(hintText: 'Coloque uma descrição sua'),
        ),
        ElevatedButton(
          onPressed: (){
            setState((){
              _futurePost = httpService.updatePosts(int.parse(_controllerUserID.text),int.parse(_controllerID.text),_controllerTitle.text,_controllerBody.text, widget.iCount);
            });
            Navigator.of(context).pop();
            setState(() {});
          }, 
          child: const Text("Editar Post")
        )
      ],
    );
  }

  FutureBuilder<Post> buildFutureBuilder() {
    return FutureBuilder<Post>(
      future: _futurePost,
        builder: (context, AsyncSnapshot<Post> snapshot){
          if(snapshot.hasData){
            Post posts = snapshot.data!;
            return Scaffold(
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
                              subtitle: Text(snapshot.data!.title),
                            ),
                            ListTile(
                              title: Text('ID'),
                              subtitle: Text('${snapshot.data!.id}'),
                            ),
                            ListTile(
                              title: Text('Body'),
                              subtitle: Text(snapshot.data!.body),
                            ),
                            ListTile(
                              title: Text('ID do usuário'),
                              subtitle: Text('${snapshot.data!.userId}'),
                            ),
                            ElevatedButton(
                              child: Text('Voltar ao início'),
                              onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => PostsPage()),
                              )
                            )
                          ],
                        )
                      )
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          else if (snapshot.hasError){
            return Text("${snapshot.error}");
          }
          return Center(
              child: CircularProgressIndicator());
        },
      );
  }

}