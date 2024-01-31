

import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _userInputData=[];

  TextEditingController titleController = TextEditingController();
  _saveData(){
    String newTask = titleController.text;
    setState(() {
      _userInputData.add(newTask);
    });
    Navigator.pop(context);
  }

  _editData(int index){
    titleController.text = _userInputData[index]; // pre-fill the text field with the current item
    showModalBottomSheet(context: context, builder: (ctx){
      return Column(
        children: [
          TextField(decoration: InputDecoration(hintText: 'Task Title'),controller: titleController,),
          ElevatedButton(onPressed: (){
            setState(() {
              _userInputData[index] = titleController.text; // replace the item at the given index
            });
            Navigator.of(ctx).pop(); // close the modal bottom sheet
          }, child:  Text('Save'))
        ],
      );
    });
  }



  _deleteData(int num){
    setState(() {
      _userInputData.removeAt(num);
    });

  }

 _addData(){
   showModalBottomSheet(context: context, builder: (ctx){
     return Column(
       children: [
         TextField(decoration: InputDecoration(hintText: 'Task Title'),controller: titleController,),
         ElevatedButton(onPressed:_saveData, child:  Text('Save'))
       ],
     );
  /*
       AlertDialog(title: Text('Save'),actions: [
       ElevatedButton(onPressed: (){}, child: Text('Save'),),
       ElevatedButton(onPressed: (){}, child: Text('Cancel'),),
     ],);*/
   });
 }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      floatingActionButton: FloatingActionButton(onPressed:_addData,child: const Icon(Icons.add),),
      body: Column(

        children: [
          SizedBox(height: 60,),
          Text('List Of Todo s '),
          Expanded(
            child: ListView.builder(itemCount: _userInputData.length,itemBuilder: (context,index){
              return Card(
                child: ListTile(
                  title: Text(_userInputData[index]),
                  leading: IconButton(onPressed:(){ _editData(index);},icon: Icon(Icons.edit),),
                  trailing: IconButton(onPressed:(){ _deleteData(index);} ,icon: Icon(Icons.delete),),
                ),
              );

            }),
          )

        ],
      ),
    );
  }
}
