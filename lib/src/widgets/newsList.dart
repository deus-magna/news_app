import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/theme/app_theme.dart';

class NewsList extends StatelessWidget {

  final List<Article> news;

  const NewsList( this.news );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.news.length,
      itemBuilder: (BuildContext context, int index) { 

        return _Notice(notice: this.news[index], index: index,);
       },
    );
  }
}

class _Notice extends StatelessWidget {

  final Article notice;
  final int index;

  const _Notice({ @required this.notice, @required this.index});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _CardTopBar(notice: notice, index: index),
        _CardTitle( notice: notice ),
        _CardImage( notice ),
        _CardBody( notice ),
        SizedBox(height: 10,),
        Divider(),
        _cardButtons(),
      ],
    );
  }
}

class _cardButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () {},
            fillColor: appTheme.accentColor,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
            child: Icon( Icons.star_border),
          ),
          SizedBox(width: 10,),
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
            child: Icon( Icons.more),
          )
        ],
      ),
    );
  }
}

class _CardBody extends StatelessWidget {

  final Article notice;

  const _CardBody(this.notice);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text( (notice.description != null) ? notice.description : '' ),
    );
  }
}

class _CardImage extends StatelessWidget {

  final Article notice;

  const _CardImage(this.notice);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
            child: Container(
          child: FadeInImage(
            placeholder: AssetImage('assets/img/giphy.gif'), 
            image: notice.urlToImage != null 
            ? NetworkImage(notice.urlToImage)
            : AssetImage('assets/img/no-image.png')
          ),
        ),
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {

   final Article notice;

  const _CardTitle({@required this.notice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 15),
      child: Text(notice.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
    );
  }
}

class _CardTopBar extends StatelessWidget {

  final Article notice;
  final int index;
  const _CardTopBar({
    @required this.notice, @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Text('${index + 1}', style: TextStyle( color: appTheme.accentColor),),
           Text('${ notice.source.name }'),
      ],),
    );
  }
}
