import 'package:flutter/material.dart';
import 'package:newsapitestapp/Helper/news.dart';
import 'package:newsapitestapp/Models/article_model.dart';
import 'package:newsapitestapp/Pages/article.dart';

class Category extends StatefulWidget {
  final String category;
  Category({required this.category});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNews newsClass = CategoryNews();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('NewsApi'),
            Text(
              'TestApp',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            )
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          )
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: Container(
              child: CircularProgressIndicator(),
            ))
          : SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return BlogTile(
                          imageUrl: articles[index].urlToImage,
                          title: articles[index].title,
                          description: articles[index].description,
                          url: articles[index].url,
                        );
                      }),
                ),
            ],
        ),
      )
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, description, url;
  BlogTile(
      {required this.imageUrl, required this.title, required this.description, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Article(
              blogUrl: url,
            )
          ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              description,
              style: TextStyle(color: Colors.black26),
            ),
          ],
        ),
      ),
    );
  }
}
