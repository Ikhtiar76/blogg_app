int calculateReadingTime(String content) {
  final words = content.trim().split(RegExp(r'\s+')).length;
  const wordsPerMinute = 200;
  final readingTime = (words / wordsPerMinute).ceil();
  return readingTime;
}
