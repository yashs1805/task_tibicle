
import 'package:flutter/material.dart';
import 'package:flutter_task/generated/l10n.dart';
import 'package:flutter_task/ui/movie_list_page.dart';
import 'package:provider/provider.dart';

import '../localization/langauge_change_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController nameController;
  ValueNotifier<List<Education>> educationDetails = ValueNotifier([]);

  @override
  void initState() {
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[

              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child:  Text(
                    S.of(context).welcomeText,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: DropdownButtonFormField(
                  value: "India",
                  items: [
                    DropdownMenuItem(
                      value: "India",
                      child: Text("India"),
                    ),
                    DropdownMenuItem(
                      value: "USA",
                      child: Text("USA"),
                    ),
                  ],
                  onChanged: (value) {
                    if(value == "India") {
                      context
                          .read<LanguageChangeProvider>()
                          .changeLocale("hi");
                    } else if (value == "USA") {
                      context
                          .read<LanguageChangeProvider>()
                          .changeLocale("en");
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Country',
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Education',
                    style: TextStyle(fontSize: 20),
                  )),

              ValueListenableBuilder(
                  valueListenable: educationDetails,
                  builder: (context, value, child) {
                    return ListView(
                      shrinkWrap: true,
                      children: [addEducation()]
                        ..addAll(value.map((e) {
                          TextEditingController educationName = TextEditingController(text: e.educationName);
                          TextEditingController educationYear = TextEditingController(text: e.educationYear);
                          TextEditingController instituteName = TextEditingController(text: e.instituteName);
                          return Card(
                            child: Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          child: TextField(
                                            controller: educationName,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Education Name',
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          child: TextField(
                                            controller: educationYear,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Education Year',
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          child: TextField(
                                            controller: instituteName,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Institute Name',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    color: Colors.blue,
                                    child: IconButton(
                                      onPressed: () {
                                        educationDetails.value.remove(e);
                                        educationDetails.notifyListeners();
                                      },
                                      icon: Icon(Icons.remove),
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList()),
                    );
                  }
              ),

              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Register'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 10,),
                                Text("Education Details",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 10,),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                    child: Center(child: Text("Education Name",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ))),
                                Expanded(
                                    flex: 3,
                                    child: Center(child: Text("Institute Name",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ))),
                                Expanded(
                                    flex: 2,
                                    child: Center(child: Text("Year",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ))),
                              ],
                            ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: educationDetails.value.length,
                                  itemBuilder: (context, index) {
                                    var details = educationDetails.value[index];
                                    return Row(
                                      children: [
                                        Expanded(flex: 3,child: Center(child: Text(details.educationName))),
                                        Expanded(flex: 3,child: Center(child: Text(details.instituteName))),
                                        Expanded(flex: 2,child: Center(child: Text(details.educationYear))),
                                      ],
                                    );
                                  },
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.blue,
                                          ),
                                        ),
                                        child: TextButton(child: Text("Cancel",), onPressed: () {
                                          Navigator.pop(context);
                                        },),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                        ),
                                        child: TextButton(child: Text("Continue",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ), onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieListPage()));
                                        },),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  )
              ),
              /*Row(
                children: <Widget>[
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      //signup screen
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),*/
            ],
          )),
    );
  }

  addEducation() {
    TextEditingController educationName = TextEditingController();
    TextEditingController educationYear = TextEditingController();
    TextEditingController instituteName = TextEditingController();
    return Card(
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: educationName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Education Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: educationYear,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Education Year',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: instituteName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Institute Name',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              color: Colors.blue,
              child: IconButton(
                onPressed: () {
                  if(educationName.text.trim().isEmpty || instituteName.text.trim().isEmpty || educationYear.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please add education details")));
                    return ;
                  }
                  educationDetails.value.add(Education(
                    educationName: educationName.text.trim(),
                    instituteName: instituteName.text.trim(),
                    educationYear: educationYear.text.trim(),
                  ));
                  educationName.clear();
                  educationYear.clear();
                  instituteName.clear();
                  educationDetails.notifyListeners();
                },
                icon: Icon(Icons.add),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Education {
  String educationName;
  String educationYear;
  String instituteName;

  Education({this.educationName = "",
    this.educationYear = "",
    this.instituteName = "",
  });
}