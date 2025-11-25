
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment{
static final url = dotenv.env['POCKETBASE_URL'] ?? 'https://testauth.meapp.com.ar';

}