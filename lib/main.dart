// ignore_for_file: prefer_final_fields

import 'package:api_projects/service/user_service.dart';
import 'package:flutter/material.dart';

import 'model/user_model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserService _service = UserService();
  bool? isLoading;
  List<UserModelData?> users = [];

  @override
  void initState() {
    super.initState();
    _service.fetchUsers().then((value) {
      // tüm değerleri çekecek
      if (value != null && value.data != null) {
        // eğer boş değilse gelenler
        setState(() {
          users = value.data!; // users'a aktaracak
          isLoading =
              true; // CircularProgressIndicator trueyu görünce veriyi yazdıracak
        });
      } else {
        setState(() {
          isLoading =
              false; // CircularProgressIndicator'e false gidecek ve dönmeye devam edecek
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('API UYGULAMASI'),
          centerTitle: true,
        ),
        body: isLoading == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : isLoading == true
                ? ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("${users[index]!.firstName!}" +
                            " ${users[index]!.lastName!}"),
                        subtitle: Text(users[index]!.email!),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(users[index]!.avatar!),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text("Bir sorun oluştu.."),
                  ),
      ),
    );
  }
}
