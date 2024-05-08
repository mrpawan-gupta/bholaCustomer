import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";

class ConversationList extends StatefulWidget{
  ConversationList({super.key, required this.name,required this.messageText,
    required this.imageUrl,required this.isMessageRead});
  String name;
  String messageText;
  String imageUrl;
  bool isMessageRead;
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      },
      child: Container(
        padding: const EdgeInsets.only(left: 0,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.imageUrl),
                    backgroundColor: AppColors().appGreyColor,
                    maxRadius: 30,
                  ),
                  const SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: AppColors().appTransparentColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.name, style: const TextStyle(fontSize: 16),),
                          const SizedBox(height: 6,),
                          Text(widget.messageText,style: TextStyle(fontSize: 13,
                              color: AppColors().appGreyColor,
                              fontWeight: widget.isMessageRead?
                              FontWeight.bold:FontWeight.normal,),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
