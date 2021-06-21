import 'package:foxbit_hiring_test_template/data/helpers/websocket.dart';
import 'package:foxbit_hiring_test_template/domain/entities/coin.dart';
import 'package:foxbit_hiring_test_template/domain/repositories/coins_repository.dart';

class CoinsRepository implements ICoinsRepository {
  final String _listEvent = 'getInstruments';
  final String _detailEvent = 'SubscribeLevel1';

  @override
  Future<List<Coin>> list(FoxbitWebSocket ws) async {
    final updatedCoins = <Coin>[];
    ws.send(_listEvent, {});

    final map = await ws.stream
        .firstWhere((message) => message['n'].toString() == _listEvent);
    final coins = extractListFrom(map);

    for (final item in coins) {
      final coin = await update(ws, item);
      updatedCoins.add(coin.copyAndMerge(item));
    }
    return updatedCoins;
  }

  @override
  Future<Coin> update(FoxbitWebSocket ws, Coin coin) async {
    ws.send(_detailEvent, {'InstrumentId': coin.id});
    final map = await ws.stream
        .firstWhere((message) => message['n'].toString() == _detailEvent);

    final object = map['o'] as Map<String, dynamic>;

    return Coin.fromMap(object);
  }

  List<Coin> extractListFrom(Map map) {
    final list = map['o'] as List;
    return list
        .where((e) => e['SessionStatus'] == 'Running')
        .map((e) => Coin.fromMap(e as Map<String, dynamic>))
        .toList();
  }
}
