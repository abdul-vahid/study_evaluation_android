library sdk;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class BuildConfig {
  static String baseUrl = "";
  static String pgUrl = "";
  static String pgTxnUrl = "";
  static String filePath = "";

  static loadConfig({bool? isUATEnv}) async {
    if (isUATEnv==true) {
      await dotenv.load(fileName: "packages/billDeskSDK/assets/.env_uat");
      baseUrl = dotenv.get('baseUrl');
      pgUrl = dotenv.get('pgUrl');
      pgTxnUrl = dotenv.get('pgTxnUrl');
      filePath = 'packages/billDeskSDK/files/indexUat.html';
    } else {
      await dotenv.load(fileName: "packages/billDeskSDK/assets/.env_prod");
      baseUrl = dotenv.get('baseUrl');
      pgUrl = dotenv.get('pgUrl');
      pgTxnUrl = dotenv.get('pgTxnUrl');
      filePath = 'packages/billDeskSDK/files/indexProd.html';
    }
  }
}

