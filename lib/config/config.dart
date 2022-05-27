class Config {
  //正式环境
  // static String baseUrl = "https://fx.soopay.net/digital/";

  //测试环境
  // static String baseUrl = "https://uatfx.soopay.net/dev176/digitalRmb/";

  //dev
  static String baseUrl = "http://10.10.55.71:8201/";

 
  // http://10.10.55.71:8201/agent/file/upload  ，
  // 集成商path你就换成agent，
  // 商户merchant，
  // 交易transaction

  //  http://10.10.55.71:8201/agent/file/upload
  //  http://10.10.55.71:8201/merchant/file/upload
  //  http://10.10.55.71:8201/transaction/file/upload



  //图片展示的基地址
  static String imageAvatarBaseUrl =
      "${Config.baseUrl}user/file/download?path=";

      
}
