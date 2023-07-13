class ItemsModal {
  int? price;
  String? id;
  String? name;

  ItemsModal({this.price, this.id, this.name});

  ItemsModal.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
