import 'package:flutter/material.dart';
import 'package:flutter_apirest/post_detail.dart';
import 'http_service.dart';
import 'post_model.dart';
import 'add_post.dart';

class PostsPage extends StatefulWidget {


  PostsPage({Key? key}) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final HttpService httpService = HttpService();

  GlobalKey<ScaffoldState>? _scaffoldKey;

  @override
  void initState() {
    // initializing states
    _scaffoldKey = GlobalKey();
    super.initState();
  }
 
  // This method will run when widget is unmounting
  @override
  void dispose() {
    // disposing states
    _scaffoldKey?.currentState?.dispose();
    super.dispose();
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: Center(
        child: FutureBuilder(
          future: httpService.getPosts(),
          builder: (context, AsyncSnapshot<List<Post>> snapshot){
            if(snapshot.hasData){
              List<Post> posts = snapshot.data!;
              int length = posts.length;
              
              return RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(
                    Duration(seconds: 1),
                    () {
                      /// adding elements in list after [1 seconds] delay
                      /// to mimic network call
                      ///
                      /// Remember: [setState] is necessary so that
                      /// build method will run again otherwise
                      /// list will not show all elements
                      setState(() {
                      });
      
                      // showing snackbar

                    });
                },
                child:ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: (Text(posts[index].title)),
                      subtitle: Text("${posts[index].id}"),
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => PostDetail(post: posts[index], iCount: index,))
                        ),
                    );
                  },
                )
              );
                
            }
            else{
              return Center(
                child: CircularProgressIndicator());
            }
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AddPost())
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}