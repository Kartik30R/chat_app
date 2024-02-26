import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hashtag/components/chatbubble.dart';

import 'package:hashtag/components/my_text_field.dart';
import 'package:hashtag/services/chat/chat_services.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.receiveUserEmail, required this.receiverUserID});
final String receiveUserEmail;
final String receiverUserID;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
final TextEditingController _messageController= TextEditingController(); 
final ChatService _chatService = ChatService();
final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;

void sendMessage()  async{
  if(_messageController.text.isNotEmpty){

    await _chatService.sendMessage(widget.receiverUserID, _messageController.text);
    // clear controller

    _messageController.clear();
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiveUserEmail),),
      body: Column(children: [Expanded(child: _buildMessageList()),
            SizedBox(height: 25,),

      _buildMessageInput(),
      ],),
    );



  }
//message list
Widget _buildMessageList(){

  return StreamBuilder(stream: _chatService.getMessages( widget.receiverUserID,_firebaseAuth.currentUser!.uid), builder: (context, snapshot) {
    if(snapshot.hasError
    ){
      return Text('error${snapshot.error}');
    }
    if(snapshot.connectionState== ConnectionState.waiting){
      return const Text('loading...');
    }
    return ListView(
      children: snapshot.data!.docs.map((e) => _buildMessageitem(e)).toList(),
    );
  },);
}
// messages

Widget _buildMessageitem(DocumentSnapshot document){

  Map<String ,dynamic> data = document.data() as Map<String,dynamic>;

  var alignment = (data['senderId']== _firebaseAuth.currentUser!.uid)
  ? Alignment.centerRight:Alignment.centerLeft;

  return Container(
    alignment: alignment,
    child: Padding(
      padding:  EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: (data['senderId']==_firebaseAuth.currentUser!.uid)?CrossAxisAlignment.end:CrossAxisAlignment.start,
        mainAxisAlignment: (data['senderId']==_firebaseAuth.currentUser!.uid)? MainAxisAlignment.end:MainAxisAlignment.start,
        children:[Text(data['senderEmail']),
        SizedBox(height: 5,),
        ChatBubble(message: data['message'],)]
      ),
    ),
  );
}


// message textfield
 Widget _buildMessageInput(){

 return Padding(
   padding: const EdgeInsets.all(25),
   child: Row(
    children: [
      Expanded(child: MyTextfield(controller: _messageController, obscureText: false, hintText: 'Enter message',)), IconButton(onPressed: sendMessage, icon: Icon(Icons.arrow_upward))
    ],
   ),
 );


 }
}