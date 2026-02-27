class Parish {
  final String name;
  final String address;
  final String sunday;
  final String weekday;
  final String prayer;

  Parish({
    required this.name,
    required this.address,
    required this.sunday,
    required this.weekday,
    required this.prayer,
  });
}

// Data for your 3 parishes
List<Parish> dcciParishes = [
  Parish(
    name: "Upper Room Parish",
    address: "#80 School Road by Asa Road, Aba",
    sunday: "8:00 AM",
    weekday: "Wednesday Bible Study - 5:00 PM",
    prayer: "Friday Prayer Meeting - 5:00 PM",
  ),
  // Add the other 2 parishes here similarly
];
