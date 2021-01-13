import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';

class ImageConverter
 {
 
 
  static Image imageFromBase64String(String base64String, {BoxFit fit = BoxFit.fill}) 
  {
    return Image.memory(
      base64Decode(base64String),
      fit: fit,
    );
  }


  static AssetImage assetImageFromBase64String(String base64String)
  {
      return Image.memory(
        base64Decode(base64String),
        fit: BoxFit.fill
      ).image;
  }


  static Uint8List dataFromBase64String(String base64String) 
  {
    return base64Decode(base64String);
  }


  static String base64String(Uint8List data) 
  {
    return base64Encode(data);
  }
}