import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icon_broken/icon_broken.dart';

void toast(String messange, Color color) {
  Fluttertoast.showToast(
      msg: messange,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

Widget myDivider() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey,
    );

Widget BuildNewsItem (context,String? image)=> Padding(
  padding: const EdgeInsets.only(top: 3.0,left: 8,right: 8),
  child: Column(
    children: [
      Card(
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0,left: 8,right: 8),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('https://mc.webpcache.epapr.in/mcms.php?size=medium&in=https://mcmscache.epapr.in/post_images/website_350/post_15704806/thumb.jpg'),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Islam Khalid',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('October 7,2023 at 10:00 Am',
                          style: Theme.of(context).textTheme.labelSmall
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: myDivider(),
              ),
              Card(
                elevation: 5,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image(image: NetworkImage(image ?? 'https://cdn.cfr.org/sites/default/files/styles/full_width_xl/public/image/2019/05/Quiz_IsraelPalestine_New.jpg.webp'),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(IconBroken.Heart,color: Colors.red,size: 20,),
                    SizedBox(width: 5,),
                    Text('10.3 M',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Spacer(),
                    Icon(IconBroken.Chat,color: Colors.amber,size: 20,),
                    SizedBox(width: 5,),
                    Text('5.8 M',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: myDivider(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8,left: 8,),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage('https://mc.webpcache.epapr.in/mcms.php?size=medium&in=https://mcmscache.epapr.in/post_images/website_350/post_15704806/thumb.jpg'),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.grey)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(' Write a comment ...   ',
                                style: Theme.of(context).textTheme.labelSmall
                            ),
                          ),
                        ),
                      ),
                    ),

                    IconButton(onPressed: (){}, icon: Icon(IconBroken.Heart,color: Colors.red,size: 20,),),
                    IconButton(onPressed: (){}, icon: Icon(IconBroken.Send,color: Colors.green,size: 20,),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
);
