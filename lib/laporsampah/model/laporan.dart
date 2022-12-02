class Laporan {
  final String date;
  final String location;
  final String urgency;
  final String description;
  final String contact;

  const Laporan({
    required this.date,
    required this.location,
    required this.urgency,
    required this.description,
    required this.contact,
  });

  factory Laporan.fromJson(Map<String, dynamic> json) {
    return Laporan(
      date: json['the_date'],
      location: json['the_location'],
      urgency: json['the_urgency'],
      description: json['the_description'],
      contact: json['the_contact'],
    );
  }
}
