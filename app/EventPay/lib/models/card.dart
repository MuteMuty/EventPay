import 'dart:convert';

import 'transaction.dart';

/// Model representing base card info.
class EventPayCard {
  /// The eventName of the card.
  final String eventName;

  /// The startTime of the card.
  final String startTime;

  /// The endTime of the card.
  final String endTime;

  /// The cardNumber of the card.
  final String cardNumber;

  /// The image of the card.
  final String image;

  /// The amount of the card.
  final num amount;

  final String location;

  /// The transactions of the card.
  final List<EventPayTransaction> transactions;

  /// Constructs new `EventPayCard` object.
  const EventPayCard({
    required this.eventName,
    required this.startTime,
    required this.endTime,
    required this.cardNumber,
    required this.image,
    required this.amount,
    required this.transactions,
    required this.location,
  });

  /// Constructs new `EventPayCard` object from [json].
  EventPayCard.fromJson(Map<String, dynamic> json)
      : eventName = json[EventPayCardJsonKey.eventName],
        startTime = json[EventPayCardJsonKey.startTime],
        endTime = json[EventPayCardJsonKey.endTime],
        cardNumber = json[EventPayCardJsonKey.cardNumber],
        image = json[EventPayCardJsonKey.image],
        amount = json[EventPayCardJsonKey.amount],
        location = json[EventPayCardJsonKey.location],
        transactions = (json[EventPayCardJsonKey.transactions])
            .map<EventPayTransaction>((i) => EventPayTransaction.fromJson(i))
            .toList();

  /// Converts this object into json representation.
  @override
  Map<String, Object?> toJson() {
    return <String, Object?>{
      EventPayCardJsonKey.eventName: eventName,
      EventPayCardJsonKey.startTime: startTime,
      EventPayCardJsonKey.endTime: endTime,
      EventPayCardJsonKey.cardNumber: cardNumber,
      EventPayCardJsonKey.image: image,
      EventPayCardJsonKey.amount: amount,
      EventPayCardJsonKey.location: location,
      EventPayCardJsonKey.transactions: jsonEncode(transactions),
    };
  }

  /// Returns new instance of `EventPayCard` with modified fields.
  EventPayCard copyWith({
    String? eventName,
    String? startTime,
    String? endTime,
    String? cardNumber,
    String? image,
    String? location,
    num? amount,
    List<EventPayTransaction>? transactions,
  }) {
    return EventPayCard(
      eventName: eventName ?? this.eventName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      cardNumber: cardNumber ?? this.cardNumber,
      image: image ?? this.image,
      amount: amount ?? this.amount,
      transactions: transactions ?? this.transactions,
      location: location ?? this.location
    );
  }
}

/// Keys used in `EventPayCard` json representations.
abstract class EventPayCardJsonKey {
  /// Key for `EventPayCard.eventName`.
  static const String eventName = 'eventName';

  /// Key for `EventPayCard.startTime`.
  static const String startTime = 'startTime';

  /// Key for `EventPayCard.endTime`.
  static const String endTime = 'endTime';

  /// Key for `EventPayCard.cardNumber`.
  static const String cardNumber = 'cardNumber';

  /// Key for `EventPayCard.image`.
  static const String image = 'image';

  /// Key for `EventPayCard.amount`.
  static const String amount = 'amount';

  /// Key for `EventPayCard.transactions`.
  static const String transactions = 'transactions';
  static const String location = 'location';
}
