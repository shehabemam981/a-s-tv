class watchlistmodel{
num? id;
String? title;
String? image;
String? details;

watchlistmodel({
   this.id,
   this.title,
   this.image,
   this.details,

});
 Map<String,dynamic> toJson(){
   return {
     "id":id,
     "title":title,
     "image":image,
     "details":details,
   };
 }
 watchlistmodel.fromJson(Map<String, dynamic> json):this(
   id: json["id"],
title: json["title"],
    image: json["image"],
    details: json["details"],
 );
}