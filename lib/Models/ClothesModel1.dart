class Clothes {
  late String name , image , price , description , category , id;
  late int quantity = 0;
  late bool fav = false;

  Clothes.model1({required this.name , required this.image});
  //Clothes.model1(image : "", name : "");
  Clothes.model2({required this.image ,required this.fav ,required this.name ,required this.description , required this.price ,required this.quantity});
  //Clothes.model2(image : "", name : "" , description : "" , price : "" , quantity : , fav : ),
  Clothes.modelSave({required this.name ,required this.price , required this.description ,required this.id ,required this.image , required this.category});
  //Clothes.modelSave(name : "", price : "" , description : "" , id : , image : "" , category : ""),
  toJson(){
    return {
      "name" : name,
      "price" : price ,
      "description" : description ,
      "id" : id,
      "image" : image ,
      "category" : category
    };
  }
  fromJson(){

  }
}