import 'package:foxbit_hiring_test_template/data/helpers/websocket.dart';
import 'package:foxbit_hiring_test_template/domain/entities/coin.dart';

abstract class ICoinsRepository {
  Future<List<Coin>> list(FoxbitWebSocket ws);
  Future<Coin> update(FoxbitWebSocket ws, Coin coin);
}
