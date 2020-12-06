import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;


final _BASE_URL = 'https://newsapi.org/v2';
final _API_KEY = '3cf990a642ba410bb34f45e40478640e';

class NewsService with ChangeNotifier {

  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology')
  ];

  Map<String, List<Article>> categoryArticles = {};
     
  NewsService(){
    this.getTopHeadlines();

    categories.forEach((item) {

        this.categoryArticles[item.name] = new List();
    });

    this.getArticlesByCategory(this._selectedCategory);
  }

  get selectedCategory => this._selectedCategory;

  set selectedCategory( String value ) {
    this._selectedCategory = value;
    this.getArticlesByCategory(value);
    notifyListeners();
  }

  List<Article> get getArticlesInCategory => this.categoryArticles[ this.selectedCategory ];

  getTopHeadlines () async {
    
    final url = '$_BASE_URL/top-headlines?apiKey=$_API_KEY&country=ca';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson( resp.body );

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory ( String category ) async {

    if( this.categoryArticles[category].length > 0) {
      return this.categoryArticles[category];
    }
    final url = '$_BASE_URL/top-headlines?apiKey=$_API_KEY&country=ca&category=$category';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson( resp.body );

    this.categoryArticles[category].addAll(newsResponse.articles);
    notifyListeners();
  }
}