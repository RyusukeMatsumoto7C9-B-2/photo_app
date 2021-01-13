import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // カメラロール等へのアクセスに必要.

import 'package:photo_app/OmoidePhotoListShowPage.dart';
import 'package:photo_app/PhotoDataSqfliteRepository.dart';
import 'package:photo_app/PhotoEditPage.dart';
import 'package:photo_app/ImageConverter.dart';
import 'package:photo_app/Photo.dart';


class OmoidePage extends StatelessWidget
{
  OmoidePage({Key key}) : super(key: key);

  final double _buttonWidth = 100;
  final double _buttonHeight = 80;

  PhotoDataSqfliteRepository photoDataRepository = PhotoDataSqfliteRepository();


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
          children: <Widget>[

            // 思い出を見るボタン.
            RaisedButton(
              child: Container(
                width: _buttonWidth,
                height: _buttonHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/memory_log.png')
                  )
                ),
              ),
              color: Colors.green,
              onPressed: (){
                // データベースの中身を見る処理.
                Navigator.push(context, MaterialPageRoute(builder: (context) => OmoidePhotoListShowPage()));
              },
            ),

            // カメラを起動ボタン.
            RaisedButton(
              child: Container(
                width: _buttonWidth,
                height: _buttonHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/camera_start.png')
                  )
                ),
              ),
              color: Colors.green,
              onPressed: () async 
              {
                Photo photo = await _pickImageFromCamera();
                Navigator.push(context, MaterialPageRoute(builder: (context) => PhotoEditPage(photo: photo)));
              },
            ),

            // 戻るボタン.
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

          ],
        )
      ),
    );
  }


  /// ギャラリーから画像を取得.
  /// 今回のアプリでは使う予定は今のところない.
  _pickImageFromGallery()
  {
    final picker = ImagePicker();
    picker.getImage(source: ImageSource.gallery).then((imgFile) async {
      if (imgFile != null)
      {
        String imgString = ImageConverter.base64String(await imgFile.readAsBytes());
        Photo photo = Photo(0, imgString);
        photoDataRepository.save(photo);
      }
    });
  }


  /// カメラから画像を取得.
  Future<Photo> _pickImageFromCamera() async
  {
    final picker = ImagePicker();
    Photo photo;
    await picker.getImage(source: ImageSource.camera).then((imgFile) async 
    {
      if (imgFile != null) 
      {
        String imgString = ImageConverter.base64String(await imgFile.readAsBytes());
        photo = Photo(0, imgString);
      }
    });
    return photo;
  }


}
