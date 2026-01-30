/// Represents time without a date or time zone.
///
/// [ActitoTime] is used for time-based configurations such as
/// do-not-disturb windows. It stores hours and minutes in 24-hour
/// format and enforces valid ranges.
class ActitoTime {
  /// Hour component of the time in 24-hour format.
  ///
  /// Must be between `0` and `23` (inclusive).
  final int hours;

  /// Minute component of the time.
  ///
  /// Must be between `0` and `59` (inclusive).
  final int minutes;

  /// Constructor for [ActitoTime] instance.
  ///
  /// Throws an [ArgumentError] if [hours] or [minutes] are out of range.
  ActitoTime({
    required this.hours,
    required this.minutes,
  }) {
    if (hours < 0 || hours > 23) {
      throw ArgumentError.value(hours, 'hours', 'Invalid time');
    }

    if (minutes < 0 || minutes > 59) {
      throw ArgumentError.value(minutes, 'minutes', 'Invalid time');
    }
  }

  /// Creates an [ActitoTime] from a `HH:mm` formatted string.
  ///
  /// For example: `"09:30"` or `"18:05"`.
  ///
  /// Throws an [ArgumentError] if the string is not in a valid format
  /// or represents an invalid time.
  factory ActitoTime.fromString(String time) {
    final parts = time.split(":");
    if (parts.length != 2) {
      throw ArgumentError.value(time, 'time', 'Invalid time string');
    }

    try {
      final hours = int.parse(parts[0]);
      final minutes = int.parse(parts[1]);

      return ActitoTime(
        hours: hours,
        minutes: minutes,
      );
    } on FormatException {
      throw ArgumentError.value(time, 'time', 'Invalid time string');
    }
  }

  /// Creates an [ActitoTime] from a JSON value.
  ///
  /// The expected JSON representation is a `HH:mm` formatted string.
  factory ActitoTime.fromJson(String json) => ActitoTime.fromString(json);

  /// Returns the time formatted as a `HH:mm` string.
  @override
  String toString() {
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  /// Converts this [ActitoTime] to its JSON representation.
  ///
  /// The value is serialized as a `HH:mm` formatted string.
  String toJson() => toString();
}
