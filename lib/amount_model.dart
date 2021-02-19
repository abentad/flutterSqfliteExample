class AmountModel {
  int id;
  DateTime date;
  int amount;
  AmountModel({this.amount, this.date});
  AmountModel.withId({this.id, this.amount, this.date});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['date'] = date.toIso8601String();
    map['amount'] = amount;
    return map;
  }

  //factory function allow us to create objects of this class
  factory AmountModel.fromMap(Map<String, dynamic> map) {
    return AmountModel.withId(
      id: map['id'],
      date: DateTime.parse(map['date']),
      amount: map['amount'],
    );
  }
}
