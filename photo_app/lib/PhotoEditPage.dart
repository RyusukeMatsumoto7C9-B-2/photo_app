import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:photo_app/Photo.dart';
import 'package:photo_app/ImageConverter.dart';
import 'package:photo_app/PhotoDataSqfliteRepository.dart';



class PhotoEditPage extends StatefulWidget 
{
  PhotoEditPage({Key key, this.photo}) : super(key: key);

  Photo photo;

  @override
  _PhotoEditPageState createState() => _PhotoEditPageState(photo);
}


class _PhotoEditPageState extends State<PhotoEditPage> 
{

  // グローバルキー
  GlobalKey _globalKey = GlobalKey();

  final double _buttonWidth = 100;
  final double _buttonHeight = 30;
  final Photo _photo;
  final PhotoDataSqfliteRepository _photoDataRepository = PhotoDataSqfliteRepository();
  bool buttonVisible = true;

  Image _image;

  // スタンプの情報.
  var _stampImages = ['ieinu_neutral.png', 'ieinu_fun.png', 'ieinu_doya.png',];
  double _stampScale = 2;
  Random _random = Random();
  Offset _offset = Offset(0,0);
  Image _stampImage;

  @override
  _PhotoEditPageState(this._photo);


  @override
  void initState() 
  {
    super.initState();
    _image = ImageConverter.imageFromBase64String(_photo.photo_raw_data);
    _stampImage = Image.asset('images/ieinu_neutral.png', scale: _stampScale);
  }


  @override
  Widget build(BuildContext context)
  {
    return RepaintBoundary(
      key: _globalKey,
      child: Scaffold(
        body: Container(
        color: Colors.black,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: _image
              ),

              // スタンプ.
              // 今回は松本のパワー不足により通常のImageの描画で回転、拡大縮小は行わない画像とする.
              Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Positioned(
                    top: _offset.dy,
                    left: _offset.dx,
                    child: Column(
                      children: <Widget>[
                        _stampImage,
                      ],),
                  ),

                  // ジェスチャの検出.
                  GestureDetector(

                    // 画像の変更.
                    onTapUp: (TapUpDetails details) 
                    {
                      setState(() => _switchStamp());
                    },

                    // 座標の更新.
                    onPanUpdate: (DragUpdateDetails details)
                    {
                      setState(() {_offset = Offset(_offset.dx+details.delta.dx, _offset.dy+details.delta.dy);});
                    },
                  ),
                ],
              ),


              Container(
                child: Opacity(
                  opacity: buttonVisible ? 1 : 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // 戻る.
                      RaisedButton(
                        child: Container(
                          width: _buttonWidth,
                          height: _buttonHeight,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/back.png'),
                            )
                          ),
                        ),
                        color: Colors.green,
                        onPressed: ()
                        {
                          Navigator.pop(context);
                        },
                      ),

                      // 完了.
                      RaisedButton(
                        child: Container(
                          width: _buttonWidth,
                          height: _buttonHeight,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/complete.png'),
                            )
                          ),
                        ),
                        color: Colors.green,
                        onPressed: () async
                        {
                          // ここで画像を保存する.
                          setState(() { buttonVisible = false; });
                          await Future.delayed(Duration(milliseconds: 50));
                          await _doCapture();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                )
              ),
            ],
          )
        ),
      )
    );
  }


  ///キャプチャ開始.
  Future<Null> _doCapture() async 
  {
    Photo editedPhoto = await _convertWidgetToPhoto();
    _photoDataRepository.save(editedPhoto);
  }
 

  /// _globalKeyが設定されたWidgetから画像を生成し返す.
  Future<Photo> _convertWidgetToPhoto() async 
  {
    try 
    {
      RenderRepaintBoundary boundary = _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      String imgString = ImageConverter.base64String(byteData.buffer.asUint8List());
      return Photo(0, imgString);
    }
    catch (e) 
    {
      print(e);
    }
 
    return null;
  }


  /// スタンプの切り替え.
  _switchStamp()
  {
    _stampImage = Image.asset('images/${_stampImages[_random.nextInt(3)]}', scale: _stampScale);
  }

}
