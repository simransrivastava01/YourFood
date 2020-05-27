import 'Upload.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'posts.dart';


//void main() => runApp(HomePage());

class HomePage extends StatefulWidget {

  static String id = 'welcome_screen';

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}
class _HomePageState extends State<HomePage>
{
  List <Posted1> postedList = [];

  @override
  void initState() {
    // TODO: implement noSuchMethod
    super.initState();
    DatabaseReference postedRef = FirebaseDatabase.instance.reference().child("Posts");

    postedRef.once().then((DataSnapshot snap)
        {
          var keys = snap.value.keys;
      var data = snap.value;

      postedList.clear();

      for(var individualKey in keys)
        {
          Posted1 posts = new Posted1
            (
              data[individualKey]['image'],
              data[individualKey]['description'],
              data[individualKey]['date'],
              data[individualKey]['time'],
          );
          
          postedList.add(posts);
        }
      setState(() {
        print("Length : $postedList.Length");
      });
        });
  }

  Widget build(BuildContext context)
  {
    return new Scaffold(
      appBar: new AppBar
        (
        title: new Text("Tasty Food Stuffs",
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
        centerTitle : true,
        backgroundColor:Colors.white,
      ),
      backgroundColor:Colors.white,
      body: new Container(
        child: postedList.length==0 ?  new Text(("No Post available")) : new ListView.builder
          (
          itemCount: postedList.length,
          itemBuilder: (_,index)
            {
              return postsUI(postedList[index].image,postedList[index].description,postedList[index].date,postedList[index].time);
            }
        ),
      ),

      bottomNavigationBar: new BottomAppBar(
        color:Colors.lightGreen,
        child: new Container(

            margin: const EdgeInsets.only(left: 160.0 , right: 40.0),

            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,

              children: <Widget>[

                new IconButton(
                  icon: new Icon(Icons.add_a_photo),
                  iconSize: 40,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push
                      (
                        context,MaterialPageRoute(builder: (context)
                    {
                      return new UploadPage();
                    }
                    )
                    );
                  },
                ),
              ],

            )
        ),
      ),
    );
  }
  Widget postsUI(String image,String description,String date,String time)
  {
    return new Card
      (
          elevation : 10.0,
          margin : EdgeInsets.all(15.0),

        child:new Container
          (
           padding: new EdgeInsets.all(14.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    date,
                    style: Theme.of(context).textTheme.subtitle,
                    textAlign: TextAlign.center,
                  ),
                  new Text(
                    time,
                    style: Theme.of(context).textTheme.subtitle,
                    textAlign: TextAlign.center,
                  ),

                ],
              ),

              SizedBox(height: 10.0,),
              new Image.network(image,fit: BoxFit.cover,),
              SizedBox(height: 10.0,),
              new Text(
                description,
                style: Theme.of(context).textTheme.subhead,
                textAlign: TextAlign.center,
              ),

            ],
          ),


        ),

    );

  }
}

