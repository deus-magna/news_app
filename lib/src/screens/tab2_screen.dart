import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/theme/app_theme.dart';
import 'package:newsapp/src/widgets/newsList.dart';
import 'package:provider/provider.dart';


class Tab2Screen extends StatelessWidget {

@override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: SafeArea(
              child: Column(
          children: <Widget>[
           _CategoriesList(),
           Expanded(
             child: ( newsService.getArticlesInCategory.length == 0) 
             ? Center( child:  CircularProgressIndicator(),) 
             : NewsList(newsService.getArticlesInCategory),
           ),

          ],
        ),
      )
    );
  }
}

class _CategoriesList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;
  
    return  Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index ) {

          final cName = categories[index].name;

          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                _CategoryButton(categories[index]),
                SizedBox(height: 5),
                Text( '${cName[0].toUpperCase() }${cName.substring(1)}'),
              ],
            ),
          );
        }, 
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  
  final Category category;

  const _CategoryButton( this.category );

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: (){
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = category.name;
      },
          child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon(
          category.icon,
          color: (newsService.selectedCategory == this.category.name)
          ? appTheme.accentColor
          : Colors.black45
        ),
      ),
    );
  }
}