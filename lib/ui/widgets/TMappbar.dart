import 'package:flutter/material.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screen/profile_screen.dart';
import 'package:task_manager/ui/screen/sing_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';

class TMappbar extends StatelessWidget implements PreferredSizeWidget {
  const TMappbar({
    super.key,
    this.isprofilescreenopen =false,
  });
  final bool isprofilescreenopen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(isprofilescreenopen){
          return;
        }
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const profilescreen(),),);
      },
      child: AppBar(
        backgroundColor: Appcolors.themecolor,
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MD Aminul islam Rasel',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'aminulislam@gmail.com',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () async{
                   await Authcontroller.clearUserData();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => singinscreen()),
                      (predicate) => false);
                },
                icon: Icon(Icons.logout))
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
