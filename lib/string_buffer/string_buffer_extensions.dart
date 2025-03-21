
extension StringBufferExtension on StringBuffer {
  void delete([int n = 1]) {
    String newStr = toString().substring(0, length - n);
    clear();
    write(newStr);
  }

  void newLine([int n = 1]) {
    if (n > 0) write('\n' * n);
  }

  void tab([int n = 1]) {
    if (n > 0) write('\t' * n);
  }
}
