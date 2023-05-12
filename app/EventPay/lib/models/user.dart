/// Model representing base user info.
class EventPayUser {
  /// The username of the user.
  final String username;

  /// The firstname of the user.
  final String firstname;

  /// The lastname of the user, PLAIN.
  final String lastname;

  /// The email of the user.
  final String email;

  /// The sessionId of the user
  final String sessionId;

  /// Constructs new `EventPayUser` object.
  const EventPayUser({
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.sessionId,
  });

  /// Constructs new `EventPayUser` object from [json].
  EventPayUser.fromJson(Map<String, dynamic> json)
      : username = json[EventPayUserJsonKey.username],
        firstname = json[EventPayUserJsonKey.firstname],
        lastname = json[EventPayUserJsonKey.lastname],
        email = json[EventPayUserJsonKey.email],
        sessionId = json[EventPayUserJsonKey.sessionId];

  /// Converts this object into json representation.
  @override
  Map<String, Object?> toJson() {
    return <String, Object?>{
      EventPayUserJsonKey.username: username,
      EventPayUserJsonKey.firstname: firstname,
      EventPayUserJsonKey.lastname: lastname,
      EventPayUserJsonKey.email: email,
      EventPayUserJsonKey.sessionId: sessionId,
    };
  }

  /// Returns new instance of `EventPayUser` with modified fields.
  EventPayUser copyWith({
    String? username,
    String? firstname,
    String? lastname,
    String? email,
    String? sessionId,
  }) {
    return EventPayUser(
      username: username ?? this.username,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      sessionId: sessionId ?? this.sessionId,
    );
  }
}

/// Keys used in `EventPayUser` json representations.
abstract class EventPayUserJsonKey {
  /// Key for `EventPayUser.username`.
  static const String username = 'username';

  /// Key for `EventPayUser.firstname`.
  static const String firstname = 'firstname';

  /// Key for `EventPayUser.lastname`.
  static const String lastname = 'lastname';

  /// Key for `EventPayUser.email`.
  static const String email = 'email';

  /// Key for `EventPayUser.sessionId`.
  static const String sessionId = 'sessionId';
}
