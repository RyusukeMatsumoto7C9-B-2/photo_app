import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

import 'package:photo_app/ImageConverter.dart';
import 'package:photo_app/PhotoDataSqfliteRepository.dart';
import 'package:photo_app/Photo.dart';
import 'package:photo_app/OmoidePhotoViewPage.dart';


/// 思い出一覧を表示するページ.
class OmoidePhotoListShowPage extends StatefulWidget 
{
  OmoidePhotoListShowPage({Key key}) : super(key: key);

  @override
  _OmoidePhotoListShowPageState createState() => _OmoidePhotoListShowPageState();
  
}


class _OmoidePhotoListShowPageState extends State<OmoidePhotoListShowPage> 
{
  Future<File> imageFile;
  Image image;
  PhotoDataSqfliteRepository repository;
  List<Photo> images;


  @override
  void initState()
  {
    super.initState();
    images = [];
    repository = PhotoDataSqfliteRepository();
    _refreshImages();
  }


  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () 
            {
              _deleteDataInDB();
              _refreshImages();
            },
          )
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: _gridView(),
            ),
          ],
        ),
      ),
    );
  }


  _deleteDataInDB() 
  {
    repository.deleteDataInDB();
  }


  _refreshImages() 
  {
    repository.getPhotos().then((imgs) 
    {
      setState(() {
        images.clear();
        images.addAll(imgs);
      });
    });
  }


  _gridView() 
  {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.6,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: images.map((photo) 
        {
          return RaisedButton(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: ImageConverter.imageFromBase64String(photo.photo_raw_data).image)
              ),
            ),
            onPressed: () 
            {
              print('photo id ${photo.id} 画像表示ページへ遷移します');
              Navigator.push(context, MaterialPageRoute(builder: (context) => OmoidePhotoViewPage(photo: photo)));
            },
          );
        }).toList(),
      ),
    );
  }


}