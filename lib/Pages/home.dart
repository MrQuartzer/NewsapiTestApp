import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapitestapp/Helper/data.dart';
import 'package:newsapitestapp/Helper/news.dart';
import 'package:newsapitestapp/Models/article_model.dart';
import 'package:newsapitestapp/Models/category_model.dart';
import 'package:newsapitestapp/Pages/article.dart';
import 'package:newsapitestapp/Pages/category.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News news = News();
    await news.getNews();
    articles = news.news;
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
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: Container(
              child: CircularProgressIndicator(),
            ))
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    /// Category
                    Container(
                      height: 80,
                      child: ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryTitle(
                            imageUrl: categories[index].imageUrl,
                            categorieName: categories[index].categoryName,
                          );
                        },
                      ),
                    ),

                    ///Blog
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
              ),
            ),
    );
  }
}

class CategoryTitle extends StatelessWidget {
  final imageUrl;
  final categorieName;
  CategoryTitle({this.imageUrl, this.categorieName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Category(category: categorieName.toLowerCase())));
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imageUrl.toString(),
                  width: 120,
                  height: 70,
                  fit: BoxFit.cover,
                )),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(
                categorieName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, description, url;
  BlogTile(
      {required this.imageUrl,
      required this.title,
      required this.description,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Article(
                      blogUrl: url,
                    )));
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
