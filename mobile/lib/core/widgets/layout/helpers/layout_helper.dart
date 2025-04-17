class LayoutHelper {
  static String getSectionLabel(int index) {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String result = '';
    var i = index;

    do {
      result = letters[i % 26] + result;
      i = (i ~/ 26) - 1;
    } while (i >= 0);

    return result;
  }
}
