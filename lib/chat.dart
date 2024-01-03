import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'envs.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import  'package:intl/intl.dart';
class chatInside extends StatefulWidget {
  const chatInside({super.key});

  @override
  State<chatInside> createState() => _chatInsideState();
}

class _chatInsideState extends State<chatInside> {
  final _messages = [];
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  bool isLoading = false;

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Widget _buildSubmit() {
    String tdata = DateFormat("HH:mm").format(DateTime.now());
    return Visibility(
      visible: !isLoading,
      child: Container(
        
        color: botBackgroundColor,
        child: IconButton(
          icon: const Icon(
            Icons.send_rounded,
            color: Colors.white,
          ),
          onPressed: () async {
            if (_textController.text != '') {
              setState(
                () {
                  _messages.add(
                    ChatMessage(
                      reaction: 'None',
                      text: _textController.text,
                      chatMessageType: 'user',
                      time:tdata,
                    ),
                  );
                  isLoading = true;
                },
              );

              var input = _textController.text;
              _textController.clear();
              Future.delayed(const Duration(milliseconds: 50)).then((_) => _scrollDown());
              generateResponse(input,_messages).then((value) {
                setState(() {
                  isLoading = false;
                  _messages.add(
                    ChatMessage(
                      text: value,
                      reaction: 'None',
                      chatMessageType: 'assistant',
                      time:tdata,
                    ),
                  );
                });
              });
               
                
              _textController.clear();
              Future.delayed(const Duration(milliseconds: 50))
                  .then((_) => _scrollDown());
            }
          },
        ),
      ),
    );
  }

  Expanded _buildInput() {
    return Expanded(
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(color: Colors.white),
        controller: _textController,
        decoration: const InputDecoration(
          fillColor: botBackgroundColor,
          filled: true,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        
        title: Row(children: [
          Container(
            width: 40,
            height: 40,
            child: Image.asset(
              
              'assets/images/logo.png'
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Flexible(
            child: Text(
              'ALI media',
              style: kchatname,
            ),
          ),
          Expanded(child: SizedBox()),
          ElevatedButton(
            style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.white),elevation: MaterialStatePropertyAll(0)),
            onPressed: () {
              setState(() {
                _messages.clear();
              });
            },
            child: Container(width: 40,height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey,width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10),),
              
              ),
              child: Icon(Icons.delete_outline,color: Colors.red[300],),
            ),
          )
        ]),
      ),
      body: Container(
        color: kback,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: kpost,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 0.1,
                              offset: Offset(0.00, 0.00),
                              spreadRadius: 0.05)
                        ],
                      ),
                      padding: EdgeInsets.all(20),
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText.rich(
                                    cursorColor: Colors.orange,
                                    TextSpan(children: [
                                      WidgetSpan(
                                        child: MarkdownBody(
                                          styleSheet: MarkdownStyleSheet
                                                  .fromCupertinoTheme(
                                                      CupertinoThemeData())
                                              .copyWith(
                                              textScaleFactor: 0.8,
                                              
                                            code: TextStyle(

                                                fontFamily: 'monospace',
                                                fontSize: 12,
                                                backgroundColor:
                                                    Colors.transparent,
                                                color: Colors.deepOrangeAccent,
                                                
                                                ),
                                                codeblockDecoration: BoxDecoration(color: Color.fromARGB(30, 98, 98, 98),
                                                border: Border.all(color: Colors.black),
                                                borderRadius: BorderRadius.all(Radius.circular(10))
                                                
                                                ),
                                            codeblockAlign:
                                                WrapAlignment.spaceBetween,
                                            codeblockPadding:
                                                const EdgeInsets.all(16),
                                          ),
                                          // // controller: controller,
                                          selectable: true,
                                          data: _messages[index].text,
                                        ),
                                      )
                                    ])),
                                // Text(
                                //   _messages[index].text,
                                //   style: _kpostText,
                                //   softWrap: true,
                                // ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  _messages[index].time,
                                  style: kcommentText,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 15,
                            top: 0,
                            child: Transform.translate(
                              offset: Offset(0, -45),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  border: Border.all(color: kpost, width: 5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60)),
                                ),
                                child: _messages[index].chatMessageType ==
                                  "assistant"?
                                  Icon(
                                    Icons.pest_control,
                                  color: Colors.grey,
                                  size: 25,
                                  ):
                                   Icon(
                                  Icons.person_3_rounded,
                                  color: Colors.grey,
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                          _messages[index].chatMessageType ==
                                  "assistant"
                              ? Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Transform.translate(
                                    offset: Offset(0, 40),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            border: Border.all(
                                                color: Colors.grey, width: 1.0),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                              _messages[index].updateReactions('like');
                                              });
                                            },
                                            icon: Icon(
                                              Icons.thumb_up_alt,
                                              size: 20,
                                              color:_messages[index].reaction == 'like'?Colors.yellow: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            border: Border.all(
                                                color: Colors.grey, width: 1.0),
                                          ),
                                          child: IconButton(
                                            iconSize: 20,
                                            onPressed: () {
                                              setState(() {
                                              _messages[index].updateReactions('dislike');
                                              });
                                            },
                                            icon: 
                                            Icon(
                                              Icons.thumb_down_alt,
                                              size: 20,
                                              color:_messages[index].reaction == 'dislike'?Colors.black: Colors.grey,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox(width: 1,)
                        ],
                      ),
                    ),
                  );
                },
                controller: _scrollController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  _buildInput(),
                  _buildSubmit(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



class ChatMessage {
  ChatMessage({
    required this.reaction,  
    required this.time,
    required this.text,
    required this.chatMessageType,
  });
  String reaction = 'None';
  final String time;
  final String text;
  final String chatMessageType;
  void updateReactions(String newReaction) {
    reaction = newReaction;
  }
}
