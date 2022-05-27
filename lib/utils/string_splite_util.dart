

class StringSpliteUtil {
  //将字符串切割成金额样式  比如1000000转成1.000.000  或  200000转成200.000
  //也可以将所有的.替换成,   这样就是以,分隔 比如1,000,000或者200,000
  // ignore: missing_return
  static String? getMoneyStyleStr(String text) {
    try {
      if (text == null || text.isEmpty) {
        return "";
      } else {
        String temp = "";
        if (text.length <= 3) {
          temp = text;
          return temp;
        } else {
          int count = ((text.length) ~/ 3); //切割次数
          int startIndex = text.length % 3; //开始切割的位置
          if (startIndex != 0) {
            if (count == 1) {
              temp = text.substring(0, startIndex) +
                  "," +
                  text.substring(startIndex, text.length);
            } else {
              temp = text.substring(0, startIndex) + ","; //第一次切割0-startIndex
              int syCount = count - 1; //剩余切割次数
              for (int i = 0; i < syCount; i++) {
                temp += text.substring(
                        startIndex + 3 * i, startIndex + (i * 3) + 3) +
                    ",";
              }
              temp += text.substring(
                  (startIndex + (syCount - 1) * 3 + 3), text.length);
            }
          } else {
            for (int i = 0; i < count; i++) {
              if (i != count - 1) {
                temp += text.substring(3 * i, (i + 1) * 3) + ",";
              } else {
                temp += text.substring(3 * i, (i + 1) * 3);
              }
            }
          }
          return temp;
        }
      }
    } catch (e) {
      print(e);
    }
  }
 
 
 
  //将字符串按类似银行卡格式6210 xxxx xxxx xxxx xx的格式展示
  static getPayCodeStyleStr(String code){
      int length=code.length;
      int count=length~/4;
      int shengYu=length%4;
      String  result='';
      if(length<4){
        return code;
      }else{
        for(int i=0;i<count;i++){
          String temp= code.substring(i*4,(i+1)*4);
          result+=temp+" ";
        }
        result+=code.substring(length-shengYu,length);
        return result;
      }
  }
 
 
}
