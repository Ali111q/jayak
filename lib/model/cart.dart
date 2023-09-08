import 'package:jayak/model/meal.dart';

class Cart{
  List<CartMeal> foods =[];
  int totalPrice (){
    int price =0;
    for (var element in foods) {
      price+= element.totalPrice();
    }
    return price;
  }
  void addToCart(Meal meal){
    foods.add(CartMeal(meal: meal));
  }
  void addItem(int index){
    foods[index].addItem();
  }
  void removeItem(int index){
    if (foods[index].num>1) {
      foods[index].removeItem();
    }
  }
  void removeMeal(int index){
foods.removeAt(index);
  }
   void clearCart(){
    this.foods = [];
  }
}
class CartMeal{
  CartMeal({required this.meal});
  Meal meal ;
  int num = 1; 
  int totalPrice(){
    return meal.price * num;
  }
  void addItem(){
    num +=1;
  }
  void removeItem(){
    num -=1;
  }
 
}