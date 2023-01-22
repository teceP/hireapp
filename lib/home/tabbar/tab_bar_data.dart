class TabBarViewItem {
  final String picUri;
  final String title;
  final String address;
  final double rating;
  final int ratings;
  final String advertisement;

  const TabBarViewItem({
    required this.picUri,
    required this.title,
    required this.address,
    required this.rating,
    required this.ratings,
    required this.advertisement,
  });
}

class TabBarData {
  static final List<TabBarViewItem> animals = [
    const TabBarViewItem(
      picUri: 'assets/dummy/tabbar/animals/elefant.jpg',
      title: 'Elefanten GmbH',
      address: 'Frankfuert Allee',
      rating: 5,
      ratings: 77,
      advertisement: 'Neuer Shop',
    ),
    const TabBarViewItem(
      picUri: 'assets/dummy/tabbar/animals/schwein.jpg',
      title: 'Schweini GmbH',
      address: 'Skalitzer Straße',
      rating: 4.1,
      ratings: 17,
      advertisement: 'Gratis',
    ),
    const TabBarViewItem(
      picUri: 'assets/dummy/tabbar/animals/welpe.jpg',
      title: 'Welpen GmbH',
      address: 'Lohmühlenstraße',
      rating: 4.7,
      ratings: 1127,
      advertisement: 'Heute bis 17 Uhr',
    ),
  ];

/*
    - assets/dummy/animals/elefant.jpeg
    - assets/dummy/animals/schwein.jpg
    - assets/dummy/animals/welpe.jpg*/
}
