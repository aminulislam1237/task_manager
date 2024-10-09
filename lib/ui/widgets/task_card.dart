import 'package:flutter/material.dart';
import 'package:task_manager/ui/utils/app_colors.dart';

class Taskcard extends StatefulWidget {
  const Taskcard({
    super.key,
  });

  @override
  State<Taskcard> createState() => _TaskcardState();
}

class _TaskcardState extends State<Taskcard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title of the text",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              "discripton of text",
            ),
            Text(
              "date:10/12/2024",
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildtaskstatuschip(),
                Wrap(
                  children: [
                    IconButton(onPressed: _onetabeditbutton, icon: Icon(Icons.edit)),
                    IconButton(onPressed: _onetabdeletebutton, icon: Icon(Icons.delete)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onetabeditbutton(){

    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Edit Status'),
        content:Column(
          mainAxisSize: MainAxisSize.min,
          children: ['new','complete','cancelled','progressed'].map((e){
            return ListTile(
              onTap: (){

              },
              title: Text(e),
            );
          }).toList(),
        ) ,
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Cencel')),
          TextButton(onPressed: (){}, child: Text('Okey')),
        ],

      );
    });
  }

  void _onetabdeletebutton(){}

  Widget _buildtaskstatuschip() {
    return Chip(
      label: Text(
        'new',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      side: BorderSide(color: Appcolors.themecolor),
    );
  }
}
