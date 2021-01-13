import 'package:flutter/material.dart';

// 遷移先のページ.
import 'package:photo_app/OmoidePage.dart';
import 'package:photo_app/HangOutPage.dart';


void main() 
{
  runApp(MyApp());
}


class MyApp extends StatelessWidget 
{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget 
{
  MyHomePage({Key key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> 
{
  final double _buttonWidth = 100;
  final double _buttonHeight = 80;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,

        // 背景画像.
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/background.png'), fit: BoxFit.cover)
        ),

        // メインの要素.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            // タイトル画像.
            Image.asset('images/title.png'),

            // メインのイエイヌちゃん.
            Image.asset('images/ieinu_neutral.png', width: 300, height: 300),

            // ページ遷移ボタンリスト.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,

              children: [
                RaisedButton(
                  child: Container(
                    width: _buttonWidth,
                    height: _buttonHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/hang_out.png')
                      )
                    ),
                  ),
                  color: Colors.lightBlue,
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HangOutPage()));
                    print('ふれあう');
                  },
                ),

                RaisedButton(
                  child: Container(
                    width: _buttonWidth,
                    height: _buttonHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/memory.png')
                      )
                    ),
                  ),
                  color: Colors.green,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OmoidePage()));
                    print('思い出を作る');
                  },
                ),

              ],
            )
          ],
        )
      ),
    );
  }
}
