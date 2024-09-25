import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:modulife/todos/todos.dart';
import 'package:modulife/profile/profile.dart';
import 'package:modulife/utils/app_router.gr.dart';
import 'package:modulife/widgets/custom_app_bar.dart';
import 'package:modulife/utils/app_router.dart';

import 'package:modulife_todos/modulife_todos.dart';
import 'package:modulife_todos/repositories/folder_repository.dart';
import 'package:modulife_ui_colors/modulife_ui_colors.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  List<String> get installedModules => [
        'TODO list',
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Home',
        profile: null,
        isBackButtonEnabled: false,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                filled: true,
                fillColor: UiColors.primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                color: UiColors.primaryColor,
              ),
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 6.0,
                    mainAxisSpacing: 6.0,
                  ),
                  itemCount: installedModules.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < installedModules.length) {
                      String moduleName = installedModules[index];
                      return GestureDetector(
                        onTap: () {
                          context.router.push(const TodoRoute());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: const Border(
                              bottom: BorderSide(
                                color: UiColors.background,
                                width: 5,
                              ),
                            ),
                            color: UiColors.secondaryColor,
                          ),
                          child: Center(
                            child: Text(
                              installedModules[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () {
                          // Handle adding a new module
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: const Border(
                              bottom: BorderSide(
                                color: UiColors.background,
                                width: 5,
                              ),
                            ),
                            color: UiColors.secondaryColor,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: RawMaterialButton(
        onPressed: () {},
        child: const CircleAvatar(
          radius: 33,
          backgroundColor: UiColors.primaryColor,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: UiColors.secondaryColor,
            child: Icon(
              Icons.swap_horiz,
              color: UiColors.primaryColor,
              size: 27,
            ),
          ),
        ),
      ),
    );
  }
}
