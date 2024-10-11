import '../database.dart';

class Car {
  int id; // auto incr id
  dynamic name; // pnode
  int miles; //

  String pid = '',
      title = '',
      productType = '',
      description = '',
      image = '',
      qty = '',
      variantId = '',
      variantsPrice = '',
      variantsTitle = '',
      totalPrice = '',
      sauce = "",
      side = '';

  Car(
      this.id,
      this.name,
      this.miles,
      this.pid,
      this.title,
      this.productType,
      this.description,
      this.image,
      this.qty,
      this.variantId,
      this.variantsPrice,
      this.variantsTitle,
      this.totalPrice,
      this.sauce,
      this.side);

  Car.fromMap(Map<String, dynamic> map) {
    id = map['ids'];
    name = map['name'];
    miles = map['miles'];
    pid = map['pid'];
    title = map['title'];
    productType = map['productType'];
    description = map['description'];
    image = map['image'];
    qty = map['qty'];
    variantId = map['variants_id'];
    variantsPrice = map['variants_price'];
    variantsTitle = map['variants_title'];
    totalPrice = map['total_price'];
    sauce = map['sauce'];
    side = map['side'];
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnNamed: name,
      DatabaseHelper.columnMiles: miles,
      DatabaseHelper.columnPId: pid,
      DatabaseHelper.columnTitle: title,
      DatabaseHelper.columnProductType: productType,
      DatabaseHelper.columnDecription: description,
      DatabaseHelper.columnImage: image,
      DatabaseHelper.columnQty: qty,
      DatabaseHelper.columnVId: variantId,
      DatabaseHelper.columnVTitle: variantsTitle,
      DatabaseHelper.columnVPrice: variantsPrice,
      DatabaseHelper.columnTotalPrice: totalPrice,
      DatabaseHelper.columnVSauce: sauce,
      DatabaseHelper.columnVSide: side,
    };
  }
}
