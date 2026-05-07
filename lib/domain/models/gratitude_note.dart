class GratitudeNote {
  const GratitudeNote({
    required this.id,
    required this.text,
    required this.createdAtIso,
  });

  final String id;
  final String text;
  final String createdAtIso;

  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text, 'createdAtIso': createdAtIso};
  }

  factory GratitudeNote.fromJson(Map<String, dynamic> json) {
    return GratitudeNote(
      id: json['id']?.toString() ?? '',
      text: json['text']?.toString() ?? '',
      createdAtIso: json['createdAtIso']?.toString() ?? '',
    );
  }
}
