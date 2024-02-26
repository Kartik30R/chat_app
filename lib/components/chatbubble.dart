import 'package:flutter/material.dart';
import 'package:hashtag/model/message.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});
final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue
      ),
      child: Text(message,style: TextStyle(fontSize: 16,color: Colors.white),),
    );
  }
}