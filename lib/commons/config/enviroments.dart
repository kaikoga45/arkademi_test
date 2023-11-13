import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroments {
  static final baseUrl = dotenv.get('BASE_URL');
}
