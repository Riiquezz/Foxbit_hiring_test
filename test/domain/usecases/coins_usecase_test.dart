import 'package:flutter_test/flutter_test.dart';
import 'package:foxbit_hiring_test_template/data/repositories/coins_repository.dart';
import 'package:foxbit_hiring_test_template/domain/entities/coin.dart';
import 'package:foxbit_hiring_test_template/domain/usecases/coins_usecase.dart';

import '../../connections/test_websocket.dart';
import '../../utils/default_test_observer.dart';

void main() {
  TestFoxbitWebSocket webSocket;
  CoinsUseCase useCase;
  DefaultTestObserver<CoinsUseCaseResponse> observer;

  setUp(() {
    webSocket = TestFoxbitWebSocket();
    useCase = CoinsUseCase(CoinsRepository());
    observer = DefaultTestObserver();
  });

  tearDown(() {
    useCase.dispose();
  });

  test('Validate correct execution', () async {
    useCase.execute(observer, webSocket);
    while (!observer.ended) {
      await Future.delayed(const Duration(milliseconds: 10));
    }

    expect(observer.done, true);
    expect(observer.error, false);
  });

  test('Validate websocket ping message formation', () async {
    useCase.execute(observer, webSocket);
    while (!observer.ended) {
      await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    }

    expect(observer.done, true);
    expect(observer.error, false);
    expect(webSocket.sendedMessages.last,
        '{"m":0,"i":2,"n":"SubscribeLevel1","o":"{\\"InstrumentId\\":1}"}');
  });

  test('Validate correct result', () async {
    useCase.execute(observer, webSocket);
    while (!observer.ended) {
      await Future.delayed(const Duration(milliseconds: 10));
    }

    expect(observer.done, true);
    expect(observer.data, isA<CoinsUseCaseResponse>());
    expect(observer.data.coins, isA<List<Coin>>());
  });
}
