class CategoriesModel {
  bool? status;
  CategoriesDataModel? data;
  CategoriesModel();
  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new CategoriesDataModel.fromJson(json['data']) : null;
    print('status' + status.toString());
  }
}

class CategoriesDataModel {
  int? currentPage;
  List<DataModel>? data =[];
  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    print('status' + currentPage.toString());
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data!.add(new DataModel.fromJson(v));
      });
    }

  }
}

class DataModel {
  int? id;
  String? name;
  String? image;
  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
