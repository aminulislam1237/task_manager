import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/TMappbar.dart';

class profilescreen extends StatefulWidget {
  const profilescreen({super.key});

  @override
  State<profilescreen> createState() => _profilescreenState();
}

class _profilescreenState extends State<profilescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMappbar(
        isprofilescreenopen: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 48,
              ),
              Text(
                'Update Profile',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 32,
              ),
              _buildphotopicker(),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Email'),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Frist Name'),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Last Name'),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Phone'),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Icon(Icons.arrow_circle_right_outlined))
            ],
          ),
        ),
      ),
    );
  }

  Container _buildphotopicker() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius:BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              )
            ),
            alignment: Alignment.center,
            child: Text('photo',style: TextStyle(
              color:Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),),
          ),
          const SizedBox(width: 8,),
          const Text('Seleted photo'),
        ],
      ),
    );}
}
