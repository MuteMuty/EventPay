/// Model representing base user info.
class EventPayTransaction {
  /// The created of the user.
  final String created;

  /// The amount of the user.
  final double amount;

  /// Constructs new `EventPayTransaction` object.
  const EventPayTransaction({
    required this.created,
    required this.amount,
  });

  /// Constructs new `EventPayTransaction` object from [json].
  EventPayTransaction.fromJson(Map<String, dynamic> json)
      : created = json[EventPayTransactionJsonKey.created],
        amount = json[EventPayTransactionJsonKey.amount];

  /// Converts this object into json representation.
  @override
  Map<String, Object?> toJson() {
    return <String, Object?>{
      EventPayTransactionJsonKey.created: created,
      EventPayTransactionJsonKey.amount: amount,
    };
  }

  /// Returns new instance of `EventPayTransaction` with modified fields.
  EventPayTransaction copyWith({
    String? created,
    double? amount,
  }) {
    return EventPayTransaction(
      created: created ?? this.created,
      amount: amount ?? this.amount,
    );
  }
}

/// Keys used in `EventPayTransaction` json representations.
abstract class EventPayTransactionJsonKey {
  /// Key for `EventPayTransaction.created`.
  static const String created = 'created';

  /// Key for `EventPayTransaction.amount`.
  static const String amount = 'amount';
}
