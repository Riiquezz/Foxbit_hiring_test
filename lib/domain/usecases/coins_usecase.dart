import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:foxbit_hiring_test_template/data/helpers/websocket.dart';
import 'package:foxbit_hiring_test_template/domain/entities/coin.dart';
import 'package:foxbit_hiring_test_template/domain/repositories/coins_repository.dart';

class ListCoinsUseCase
    extends UseCase<ListCoinsUseCaseResponse, FoxbitWebSocket> {
  ListCoinsUseCase(this._repository);

  final ICoinsRepository _repository;

  @override
  Future<Stream<ListCoinsUseCaseResponse>> buildUseCaseStream(
      FoxbitWebSocket params) async {
    final StreamController<ListCoinsUseCaseResponse> controller =
        StreamController<ListCoinsUseCaseResponse>();

    try {
      final list = await _repository.list(params);
      list.sort((a, b) => a.order.compareTo(b.order));
      final response = ListCoinsUseCaseResponse(list);
      controller.add(response);
      controller.close();
    } catch (e) {
      controller.addError(e);
    }

    return controller.stream;
  }
}

class ListCoinsUseCaseResponse {
  final List<Coin> _coins;
  List<Coin> get coins => [..._coins];
  ListCoinsUseCaseResponse(this._coins);
}
