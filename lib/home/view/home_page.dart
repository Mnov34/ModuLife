import 'package:flutter/material.dart';
import 'package:modulife2/profile/profile.dart';
import 'package:modulife2/tasks/tasks.dart';
import 'package:modulife2/uikit/uicolors.dart';
import 'package:modulife2/widgets/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (BuildContext _) => HomePage());
  }

  List<String> get installedModules => [
        'TODO list',
      ];

  final Map<String, Route<void> Function()> moduleRoutes = {
    'TODO list': TaskPage.route,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Home',
        profile: null,
        enableBackButton: false,
      ),
      body: Stack(
        children: [
          Container(
            color: UiColors.background,
          ),
          Column(
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
                    fillColor: UiColors.accentColor1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    color: UiColors.accentColor1,
                  ),
                  height: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                              if (moduleRoutes.containsKey(moduleName)) {
                                Navigator.of(context).push(
                                    moduleRoutes[moduleName]!(),
                                );
                              }
                            },
                          );
                          /*return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: const Border(
                                bottom: BorderSide(
                                  color: UiColors.background,
                                  width: 5,
                                ),
                              ),
                              color: UiColors.accentColor2,
                            ),
                            child: Center(
                              child: Text(
                                installedModules[index],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );*/
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
                                color: UiColors.accentColor2,
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
          Positioned(
            bottom: 20,
            right: 20,
            child: RawMaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  ProfileSelectPage.route(),
                );
              },
              child: const CircleAvatar(
                radius: 33,
                backgroundColor: UiColors.accentColor1,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: UiColors.accentColor2,
                  child: Icon(
                    Icons.swap_horiz,
                    color: UiColors.accentColor1,
                    size: 27,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
