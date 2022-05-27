class MathUtil {
  static String formatNum(double num, int position) {
    if ((num.toString().length - num.toString().lastIndexOf(".") - 1) <
        position) {
      //小数点后有几位小数
      return num.toStringAsFixed(position)
          .substring(0, num.toString().lastIndexOf(".") + position + 1)
          .toString();
    } else {
      return num.toString()
          .substring(0, num.toString().lastIndexOf(".") + position + 1)
          .toString();
    }
  }

  static String formatPrice(var price) {
    if (price != null && price.toString().length > 0) {
      List<String> mlist = price.toString().split(".");
      if (mlist[1].isNotEmpty && double.parse(mlist[1]) > 0) {
        return "¥" + price.toString() + "元";
      } else {
        return "¥" + mlist[0] + "元";
      }
    } else {
      return "";
    }
  }
}
