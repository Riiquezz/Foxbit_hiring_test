import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:foxbit_hiring_test_template/data/helpers/websocket.dart';
import 'package:foxbit_hiring_test_template/domain/entities/coin.dart';
import 'package:foxbit_hiring_test_template/domain/repositories/coins_repository.dart';

class CoinsUseCase extends UseCase<CoinsUseCaseResponse, FoxbitWebSocket> {
  CoinsUseCase(this._repository);

  final ICoinsRepository _repository;

  @override
  Future<Stream<CoinsUseCaseResponse>> buildUseCaseStream(
      FoxbitWebSocket params) async {
    final StreamController<CoinsUseCaseResponse> controller =
        StreamController<CoinsUseCaseResponse>();

    try {
      final list = await _repository.list(params);
      list.sort((a, b) => a.order.compareTo(b.order));
      final response = CoinsUseCaseResponse(list);
      controller.add(response);
      controller.close();
    } catch (e) {
      controller.addError(e);
    }

    return controller.stream;
  }
}

class CoinsUseCaseResponse {
  final List<Coin> _coins;
  List<Coin> get coins => [..._coins];
  CoinsUseCaseResponse(this._coins);
}
