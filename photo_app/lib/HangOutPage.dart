import 'package:flutter/material.dart';


class HangOutPage extends StatefulWidget 
{
  HangOutPage({Key key}) : super(key: key);

  @override
  _HangOutPageState createState() => _HangOutPageState();
}


class _HangOutPageState extends State<HangOutPage> 
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

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('images/ieinu_neutral.png', scale: 2),

            // 戻るボタン.
            RaisedButton(
              child: Container(
                width: _buttonWidth,
                height: _buttonHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('images/back.png'))
                ),
              ),
              color: Colors.green,
              onPressed: ()
              {
                print('もどる');
                Navigator.pop(context);
              },
            ),
          ],
        )
      ),
    );
  }
}
