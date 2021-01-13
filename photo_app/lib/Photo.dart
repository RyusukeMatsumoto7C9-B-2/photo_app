
// 撮影した写真データ.
class Photo 
{

  int id;
  String photo_raw_data;
  
  
  Photo(this.id, this.photo_raw_data);


  Map<String, dynamic> toMap() 
  {
    var map = <String, dynamic> {
      'id': id,
      'photo_raw_data': photo_raw_data
    };
    return map;
  }


  Photo.fromMap(
    Map<String, dynamic> map)
  {
    id = map['id'];
    photo_raw_data = map['photo_raw_data'];
  }


  
}






