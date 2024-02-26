import 'package:cloud_firestore/cloud_firestore.dart'; // Assuming Timestamp is from Firestore

class Message {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderEmail,
    required this.receiverId,
    required this.senderId,
    required this.timestamp,
    required this.message,
  });

  // Convert to a map
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail, // Corrected the missing single quote
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp.millisecondsSinceEpoch, // Assuming timestamp is of type Timestamp
    };
  }
}
