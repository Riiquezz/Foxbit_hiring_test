import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:foxbit_hiring_test_template/app/pages/coins/coins_controller.dart';
import 'package:foxbit_hiring_test_template/app/widgets/coin_card.dart';
import 'package:foxbit_hiring_test_template/domain/entities/coin.dart';

class CoinsPage extends View {
  @override
  State<StatefulWidget> createState() => CoinsState();
}

class CoinsState extends ViewState<CoinsPage, CoinsController> {
  CoinsState() : super(CoinsController());

  @override
  Widget get view => Scaffold(
        key: globalKey,
        appBar: AppBar(
          title: const Text('Cotação',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 30.0,
              )),
          centerTitle: false,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: ControlledWidgetBuilder<CoinsController>(
            builder: (context, controller) {
          return StreamBuilder<List<Coin>>(
              stream: controller.coinsListStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final coins = snapshot.data;
                  return ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: 5,
                    itemBuilder: (ctx, i) {
                      return CoinCard(coins[i]);
                    },
                  );
                } else {
                  return Container();
                }
              });
        }),
      );
}
