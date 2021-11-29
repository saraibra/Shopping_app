class HomeModel {
   bool? status;
   HomeData? data;

  HomeModel();
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data = HomeData.fromJson(json['data']);
  }
}

class HomeData {
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];
  HomeData.fromJson(Map<String, dynamic> json) {
     json['banners'].forEach((element) {

      banners.add(BannersModel.fromJson(element));
    });
    json['products'].forEach((element) {

      products.add(ProductsModel.fromJson(element));
    });
   
  }
}

class BannersModel {
   int? id;
   String? image;
  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel {
   int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
   String? name;
   String? image;
   bool? inFavourites;
   bool? inCart;
  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    name = json['name'];

    image = json['image'];
    inFavourites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
