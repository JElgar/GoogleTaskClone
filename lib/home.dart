import 'package:flutter/material.dart';

class home extends StatefulWidget {
  @override
  homeState createState() {
    return new homeState();
  }
}

class homeState extends State<home> {



  List tasks = [];
  String fieldText = null;
  //final TextEditingController controller = new TextEditngController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
//      appBar: AppBar(
//        title: Text('To Do'),
//        actions: <Widget>[
//          new IconButton(icon: new Icon(Icons.menu), onPressed: null)
//        ],
//      ),

      body: ListView.builder(
//        padding: new EdgeInsets.only(
//            top: 0.0,
//            bottom: 0.0,
//            left: 15.0,
//            right: 15.0,
//        ),
        itemCount: tasks.length,
        itemExtent: 50.0,
        itemBuilder: (BuildContext context, int index){
//          return new ListTile(
//            //contentPadding: new EdgeInsets.all(0.0),
//            leading: Icon(Icons.radio_button_unchecked),
//            title: Text(tasks[index]),
//            onTap: null,
//          );
          final task = tasks[index];
            return Dismissible(
                key: Key(task),
                background: Container(color: Colors.red),
                onDismissed: (direction) {
                  setState(() {
                    tasks.removeAt(index);
                  });
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text("$task dismissed")));
                },
                child: new ListTile(
                  leading: Icon(Icons.radio_button_unchecked),
                  title: Text(tasks[index]),
                  onTap: (){
                    setState(() {
                      tasks.removeAt(index);
                    });
                  },
                ),
            );

//          return new Container(
//            child: Row(
//              mainAxisSize: MainAxisSize.max,
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: <Widget>[
//                IconButton(icon: Icon(Icons.radio_button_unchecked), onPressed: null,),
//                Text(tasks[index])
//              ],
//            ),
//          );
//          return new Text(tasks[index]);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context){
                  return new Container(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'New Task',
                            hintStyle: new TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5 ),
                            contentPadding: new EdgeInsets.all(22.0),
                          ),
                          autofocus: true,
                          onChanged: (String str){
                            fieldText = str;
                          },
                          onSubmitted: (String str){
                            str == null || str == "" ? null : setState((){tasks.add(str);});
                            Navigator.pop(context);
                            fieldText = null;
                          },
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(color: Colors.blue, icon: Icon(Icons.add), onPressed: null, ),
                            FlatButton(textColor: Colors.blue, child: Text('Save'), onPressed: (){
                              fieldText == null ? null : setState((){tasks.add(fieldText);});
                              Navigator.pop(context);
                              fieldText = null;
                            }
                              ,),
                          ],
                        )
                      ],
                    )
                  );
                }
            );
          },
          icon: Icon(Icons.add),
          label: Text('Add a New Task'),
          backgroundColor: Colors.blueAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(icon: Icon(Icons.menu), onPressed: null),
              IconButton(icon: Icon(Icons.more_vert), onPressed: null)
            ],
          )
          ),
    );
  }
}
