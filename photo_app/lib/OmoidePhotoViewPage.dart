import 'package:flutter/material.dart';
import 'package:photo_app/ImageConverter.dart';
import 'package:photo_app/Photo.dart';


class OmoidePhotoViewPage extends StatefulWidget 
{
  OmoidePhotoViewPage({Key key, this.photo}) : super(key: key);

  Photo photo;

  @override
  _OmoidePhotoViewPageState createState() => _OmoidePhotoViewPageState(photo);
}


class _OmoidePhotoViewPageState extends State<OmoidePhotoViewPage> 
{
  Photo _photo;


  @override
  _OmoidePhotoViewPageState(this._photo);


  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('思い出フォト')
      ),
      
      body: Center(
        child: Center(        
          child: ImageConverter.imageFromBase64String(_photo.photo_raw_data)
        )
      ),
    );
  }
}
