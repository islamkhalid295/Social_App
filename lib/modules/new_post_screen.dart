import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/cubit/app_cubit.dart';
import 'package:social_app/cubit/states.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({super.key});
var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit,AppStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('New Poat'),
            actions: [
              TextButton(
                  onPressed: ()
                  {
                    Appcubit.get(context).addPost(textController.text,Appcubit.get(context).postImage ?? '');
                  },
                  child: Text('POST'))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if( state is AddNewPostLodingState)
                  LinearProgressIndicator(),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('https://mc.webpcache.epapr.in/mcms.php?size=medium&in=https://mcmscache.epapr.in/post_images/website_350/post_15704806/thumb.jpg'),
                    ),
                    SizedBox(width: 10,),
                    Text('Islam Khalid',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'What is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (Appcubit.get(context).postImage != null)
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    Appcubit.get(context).postImage!)),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                topLeft: Radius.circular(5))),
                      ),
                      CircleAvatar(
                        radius: 15,
                        child: IconButton(onPressed: (){
                          Appcubit.get(context).removePostImage();
                        },
                            icon: Icon(Icons.close,size: 15,)),
                      ),
                    ],
                  ),
                if ( state is GetPostImageLodingState)
                  LinearProgressIndicator(),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed: ()
                      {
                        Appcubit.get(context).getPostImage();
                      }, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(IconBroken.Image),
                          Text('Add Photo'),
                        ],
                      )),
                    ),

                    Expanded(child: TextButton(onPressed: (){}, child: Text('#Tages'),)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
