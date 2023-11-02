import 'package:flutter/material.dart';
import 'package:social_app/constans/constats.dart';

class ChatDetailesScreen extends StatelessWidget {
   ChatDetailesScreen({super.key});
var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  'https://firebasestorage.googleapis.com/v0/b/social-app-ad1ae.appspot.com/o/user%2FIMG_20230503_185630.jpg?alt=media&token=4699440e-db71-4865-a9b4-a2d880d0032d&_gl=1*nji5aq*_ga*MjU4OTM5OTc3LjE2OTc1ODgyMTY.*_ga_CW55HF8NVT*MTY5ODg3MjM3OS4zOC4xLjE2OTg4NzM5MjIuNDUuMC4w'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Islam Khalid',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ,bottomRight:Radius.circular(10) )

                ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('hello World'),
                  )),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                decoration: BoxDecoration(
                  color: defaultColor.withOpacity(0.2),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ,bottomLeft:Radius.circular(10) )

                ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('hello World'),
                  )),
            ),
            Spacer(),
            Card(
              elevation: 5,
              shape: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(5),
                  borderSide: BorderSide(
                      color: Colors.amber)),
              clipBehavior:
              Clip.antiAliasWithSaveLayer,
              child: Row(
                children: [
                  // Icon(Icons.comment,
                  //     color: Colors.grey),
                  Expanded(
                    child: Padding(
                      padding:
                      const EdgeInsets.only(
                          left: 10),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color:
                            Colors.grey[200],
                            borderRadius:
                            BorderRadius
                                .circular(
                                10)),
                        child: Padding(
                          padding:
                          const EdgeInsets
                              .symmetric(
                              horizontal:
                              8.0),
                          child: TextFormField(
                              maxLines: 5,
                              minLines: 1,
                              controller:
                              messageController,
                              decoration:
                              InputDecoration(
                                hintText:
                                'write your message ...',
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                border:
                                InputBorder
                                    .none,
                              )),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {

                    },
                    icon: Icon(
                      Icons.telegram_outlined,
                      color: Colors.amber,
                      size: 40,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
