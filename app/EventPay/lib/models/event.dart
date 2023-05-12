/// Model representing base event info.
class EventPayEvent {
  /// The eventId of the event.
  final int eventId;

  /// The eventName of the event.
  final String eventName;

  /// The location of the event.
  final String location;

  /// The image of the event.
  final String image;

  /// The startDate of the event
  final String startDate;

  /// The endDate of the event
  final String endDate;

  /// Constructs new `EventPayEvent` object.
  const EventPayEvent({
    required this.eventId,
    required this.eventName,
    required this.location,
    required this.image,
    required this.startDate,
    required this.endDate,
  });

  /// Constructs new `EventPayEvent` object from [json].
  EventPayEvent.fromJson(Map<String, dynamic> json)
      : eventId = json[EventPayEventJsonKey.eventId],
        eventName = json[EventPayEventJsonKey.eventName],
        location = json[EventPayEventJsonKey.location],
        image = json[EventPayEventJsonKey.image],
        startDate = json[EventPayEventJsonKey.startDate],
        endDate = json[EventPayEventJsonKey.endDate];

  /// Converts this object into json representation.
  @override
  Map<String, Object?> toJson() {
    return <String, Object?>{
      EventPayEventJsonKey.eventId: eventId,
      EventPayEventJsonKey.eventName: eventName,
      EventPayEventJsonKey.location: location,
      EventPayEventJsonKey.image: image,
      EventPayEventJsonKey.startDate: startDate,
      EventPayEventJsonKey.endDate: endDate,
    };
  }

  /// Returns new instance of `EventPayEvent` with modified fields.
  EventPayEvent copyWith({
    int? eventId,
    String? eventName,
    String? location,
    String? image,
    String? startDate,
    String? endDate,
  }) {
    return EventPayEvent(
      eventId: eventId ?? this.eventId,
      eventName: eventName ?? this.eventName,
      location: location ?? this.location,
      image: image ?? this.image,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}

/// Keys used in `EventPayEvent` json representations.
abstract class EventPayEventJsonKey {
  /// Key for `EventPayEvent.eventId`.
  static const String eventId = 'eventId';

  /// Key for `EventPayEvent.eventName`.
  static const String eventName = 'eventName';

  /// Key for `EventPayEvent.location`.
  static const String location = 'location';

  /// Key for `EventPayEvent.image`.
  static const String image = 'image';

  /// Key for `EventPayEvent.startDate`.
  static const String startDate = 'startDate';

  /// Key for `EventPayEvent.endDate`.
  static const String endDate = 'endDate';
}
