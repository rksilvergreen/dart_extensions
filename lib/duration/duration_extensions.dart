extension DurationExtension on Duration {

  operator + (Duration other) => Duration(microseconds: inMicroseconds + other.inMicroseconds);
  operator - (Duration other) => Duration(microseconds: inMicroseconds - other.inMicroseconds);
  operator * (Duration other) => Duration(microseconds: inMicroseconds * other.inMicroseconds);
  operator & (num num) => Duration(microseconds: (inMicroseconds * num).round());
  operator / (Duration other) => Duration(microseconds: (inMicroseconds / other.inMicroseconds).round());
  operator | (num num) => Duration(microseconds: (inMicroseconds / num).round());

  operator > (Duration other) => inMicroseconds > other.inMicroseconds;
  operator >= (Duration other) => inMicroseconds >= other.inMicroseconds;
  operator < (Duration other) => inMicroseconds < other.inMicroseconds;
  operator <= (Duration other) => inMicroseconds <= other.inMicroseconds;

  // bool get isPositive => inMicroseconds > 0;
  //
  // Duration get abs {
  //   int microseconds = inMicroseconds;
  //   bool isPositive = microseconds > 0;
  //   return isPositive ? this : Duration(microseconds: -microseconds);
  // }
}