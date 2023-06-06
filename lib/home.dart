import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> itemsTodo = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My TODO App"),
      ),
      body: 
      Column(
        children: <Widget>[
          Image.asset(
            "assets/img/buku.jpg",
            fit: BoxFit.cover,
            width: double.infinity,
            height: 300,
            alignment: Alignment.center,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itemsTodo.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(4),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: ListTile(
                    //tileColor: Colors.grey.shade100,
                    title: Text(itemsTodo[index]),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          itemsTodo.remove(itemsTodo[index]);                 
                        });
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ),
                );
              },
          ),
          ),
        ],
      ),
      
      
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          //Show dialog
          showDialog(context: context, builder: (context){
            TextEditingController _controller = TextEditingController();
            return AlertDialog(
              title: Text("Add a todo"),
              content: TextField(
                 decoration: const InputDecoration(hintText: 'Title'),
                 controller: _controller,
              ),
              actions: [
                TextButton(onPressed: (){
                  //Add items to the todo items
                  setState(() {
                    itemsTodo.add(_controller.text);
                  });

                  var db = FirebaseFirestore.instance;
                  db.collection("todos").doc().set({
                    "title": _controller.text,
                    "tarikh": DateTime.now().toString()
                  });                 

                  //close the dialog bila click save
                  Navigator.pop(context);


                }, child: Text("Save")),
              ]
            );
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}