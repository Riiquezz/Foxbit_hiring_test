class Coin {
  final int id;
  final String name;
  final String product;
  final int order;
  final double price;
  final double volume;
  final double change;

  Coin({
    this.price,
    this.volume,
    this.change,
    this.product,
    this.id,
    this.name,
    this.order,
  });

  Coin copyAndMerge(Coin coin) {
    return Coin(
      id: coin.id ?? id,
      name: coin.name ?? name,
      product: coin.product ?? product,
      order: coin.order ?? order,
      price: coin.price ?? price,
      volume: coin.volume ?? volume,
      change: coin.change ?? change,
    );
  }

  factory Coin.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }
    return Coin(
      id: int.tryParse(map['InstrumentId'].toString()),
      name: map['Symbol'].toString(),
      product: map['Product1Symbol'].toString(),
      order: int.tryParse(map['SortIndex'].toString()),
      price: double.tryParse(map['LastTradedPx'].toString()),
      volume: double.tryParse(map['Rolling24HrVolume'].toString()),
      change: double.tryParse(map['Rolling24HrPxChange'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'InstrumentId': id,
    };
  }
}
