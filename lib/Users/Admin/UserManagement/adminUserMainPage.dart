import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_project/Features/User/Bloc/bloc.dart';
import 'package:flutter_group_project/Users/Admin/JobDisplayScreen/adminJobDetailPage.dart';
import 'package:flutter_group_project/Users/Admin/UserManagement/UserDetail.dart';

class AdminUserMainPage extends StatelessWidget {
  static const routeName = '/admin/Features.user';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height;

    return BlocProvider.value(
      value: BlocProvider.of<UserBloc>(context),
      child: Scaffold(
        body: BlocBuilder<UserBloc, UserState>(
          builder: (_, state) {
            if (state is UserOperationFailure) {
              return Text('Could not do users operation :(');
            }
            if (state is UsersLoadSuccess) {
              final user = state.user;

              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: user.length,
                itemBuilder: (_, idx) =>
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(
                        UserDetail.routeName, arguments: user[idx]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          child: new FittedBox(
                            child: Material(
                              color: Colors.white,
                              elevation: 14.0,
                              borderRadius: BorderRadius.circular(24.0),
                              shadowColor: Color(0x802196F3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16.0),
                                      child: myDetailsContainer1(
                                          user[idx].Email,
                                          user[idx].FullName),
                                    ),
                                  ),
                                  SizedBox(width: 30,),
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 50),
                                    width: width - 16,
                                    height: height * 0.3,
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: new BorderRadius
                                              .circular(24.0),
                                          child: CircleAvatar(
                                            radius: 50,
                                            backgroundImage: AssetImage(
                                              // TODO: change this image path
                                              'Assets/Images/me.jpg',

                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15,),
                                        Text('${user[idx].FullName}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              );
            }

            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator(

              ),),
            );
          },
        ),


      ),
    );
  }

  Widget myDetailsContainer1(String title, String location) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            // TODO
              child: Text(
                "$title",
                style: TextStyle(
                    color: Color(0xffe6020a),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
        Container(
          // TODO
            child: Text(
              "$location",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }
}
