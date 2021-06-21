import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:foxbit_hiring_test_template/data/helpers/websocket.dart';
import 'package:foxbit_hiring_test_template/data/repositories/coins_repository.dart';
import 'package:foxbit_hiring_test_template/domain/entities/coin.dart';
import 'package:foxbit_hiring_test_template/domain/usecases/coins_usecase.dart';

class CoinsPresenter extends Presenter {
  Function listCoinsOnComplete;
  Function(dynamic) listCoinsOnError;
  Function(List<Coin>) listCoinsOnNext;

  final CoinsUseCase _coinsUseCase = CoinsUseCase(CoinsRepository());

  void list(FoxbitWebSocket ws) {
    _coinsUseCase.execute(_ListCoinsObserver(this), ws);
  }

  @override
  void dispose() {
    _coinsUseCase.dispose();
  }
}

class _ListCoinsObserver implements Observer<CoinsUseCaseResponse> {
  CoinsPresenter presenter;

  _ListCoinsObserver(this.presenter);

  @override
  void onNext(CoinsUseCaseResponse response) {
    assert(presenter.listCoinsOnNext != null);
    presenter.listCoinsOnNext(response.coins);
  }

  @override
  void onComplete() {
    assert(presenter.listCoinsOnComplete != null);
    presenter.listCoinsOnComplete();
  }

  @override
  void onError(dynamic e) {
    assert(presenter.listCoinsOnError != null);
    presenter.listCoinsOnError(e);
  }
}
