import 'package:flutter/material.dart';
import 'package:newsapp/src/screens/tabs_screen.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/theme/app_theme.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_)=> new NewsService() ),
          ],
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: appTheme,
        home: TabsScreen(),
      ),
    );
  }
}