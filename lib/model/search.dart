class Search{
  final int id;
  final String name;
  final String image;
  final SearchType type;

  Search({required this.id, required this.name, required this.image, required this.type});
  factory Search.fromJson(Map json, SearchType type){
    return Search(id: json['id'], name: json['name'], image: json[type!= SearchType.restaurant? 'image':'logo'], type: type);
  }
}
enum SearchType{
  food, 
  restaurant,
  favorateFood,
  FavorateResturants
}