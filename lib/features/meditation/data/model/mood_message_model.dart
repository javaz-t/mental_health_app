 import '../../domain/entities/mood_message.dart';

class MoodMessageModel extends MoodMessage {
    MoodMessageModel({required super.text});

  // Factory to build from JSON
  factory MoodMessageModel.fromJson(Map<String, dynamic> json) {
    print('json $json');
    return MoodMessageModel(text: json["advice"] as String);
  }

  // Convert model back to JSON
  Map<String, dynamic> toJson() {
    return {
      'text': text,
    };
  }

  // Optionally: convert model to entity (if you don’t extend it directly)
  MoodMessage json() => MoodMessage(text: text);
}
