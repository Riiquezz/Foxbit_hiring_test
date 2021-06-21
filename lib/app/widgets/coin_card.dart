import 'package:flutter/material.dart';
import 'package:foxbit_hiring_test_template/app/utils/format.dart';
import 'package:foxbit_hiring_test_template/domain/entities/coin.dart';

class CoinTile extends StatelessWidget {
  final Coin coin;

  const CoinTile(this.coin, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        height: 70.0,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLeading(),
            Text(
              Format.change(coin.change),
              style: TextStyle(
                  color: coin.change < 0 ? Colors.red : Colors.green,
                  fontSize: 16.0),
            ),
            FittedBox(
              child: Text(
                Format.currency(coin.price),
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeading() {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/${coin.id}.png'),
        ),
        const SizedBox(width: 4.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              coin.name ?? '',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              coin.product ?? '',
              style: TextStyle(fontSize: 12.0, color: Colors.grey[500]),
            ),
          ],
        )
      ],
    );
  }
}
