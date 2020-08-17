class GraphicInfo {
  final int position;
  final String time, icon, description;
  final List<String> graphicImages;

  GraphicInfo(
      {this.position,
      this.time,
      this.icon,
      this.description,
      this.graphicImages});
}

List<GraphicInfo> graphic = [
  GraphicInfo(
      position: 1,
      time: 'Hourly',
      icon: 'assets/jam.png',
      description: 'Show rainfall information in hours.',
      graphicImages: [
        'assets/hourly1.jpg',
        'assets/hourly2.jpg',
      ]),
  GraphicInfo(
      position: 2,
      time: 'Daily',
      icon: 'assets/hari.png',
      description: 'Show rainfall information per day.',
      graphicImages: [
        'assets/daily1.jpg',
        'assets/daily2.jpg',
      ]),
  GraphicInfo(
      position: 3,
      time: 'Weekly',
      icon: 'assets/minggu.png',
      description: 'Show rainfall information in per week.',
      graphicImages: [
        'assets/daily.PNG',
        'assets/daily.PNG',
        'assets/daily.PNG',
      ]),
];
