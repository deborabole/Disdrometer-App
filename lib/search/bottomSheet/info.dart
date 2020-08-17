class Event {
  final String assetName;
  String data;

  Event({this.assetName, this.data});
}

final List<Event> info = [
  Event(assetName: 'loc_mark.png', data: 'Ciumbuleuit'),
  Event(assetName: 'safe.png', data: 'AMAN'),
  Event(
      assetName: 'info_marker.png',
      data: 'Rainfall : 982 mm/h\nDiameter : 20 mm\nRaindrops : ~')
];
