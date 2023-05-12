class OrderPostModel {
  OrderPostModel({
    required this.cardNumber,
    required this.amount,
    required this.workerUsername,
  });
  late final String cardNumber;
  late final double amount;
  late final String workerUsername;
  
  OrderPostModel.fromJson(Map<String, dynamic> json){
    cardNumber = json['cardNumber'];
    amount = json['amount'];
    workerUsername = json['workerUsername'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cardNumber'] = cardNumber;
    _data['amount'] = amount;
    _data['workerUsername'] = workerUsername;
    return _data;
  }
}