import 'package:flutter/material.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/widgets/newsList.dart';
import 'package:provider/provider.dart';


class Tab1Screen extends StatefulWidget {

  @override
  _Tab1ScreenState createState() => _Tab1ScreenState();
}

class _Tab1ScreenState extends State<Tab1Screen> with AutomaticKeepAliveClientMixin {
@override
  Widget build(BuildContext context) {

    final headlines = Provider.of<NewsService>(context).headlines;
    

    return Scaffold(
      body: ( headlines.length == 0) 
      ? Center( child:  CircularProgressIndicator(),)
      : NewsList(headlines)
    );
  }

  @override
  bool get wantKeepAlive => true;
}