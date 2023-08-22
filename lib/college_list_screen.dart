// ignore_for_file: library_private_types_in_public_api
import 'dart:convert';
import 'package:collage_duniya/college_detail_screen.dart';
import 'package:flutter/material.dart';
import 'college_model.dart';
import 'package:http/http.dart' as http;

import 'drawer_screen.dart';

class CollegeListScreen extends StatefulWidget {
  const CollegeListScreen({super.key});

  @override
  _CollegeListScreenState createState() => _CollegeListScreenState();
}

class _CollegeListScreenState extends State<CollegeListScreen> {
  List<College> colleges = [];
  bool isLoading = true;

  TextEditingController searchController = TextEditingController();
  dynamic searchText = '';

  @override
  void initState() {
    super.initState();
    fetchColleges();
  }

  Future<void> fetchColleges() async {
    try {
      final response = await http.get(
        Uri.parse('http://universities.hipolabs.com/search?country=india'),
      );
      if (response.statusCode == 200) {
        json.decode(response.body) as List;

        final list = (json.decode(response.body) as List).map((e) {
          return College.fromJson(e);
        }).toList();
        setState(() {
          colleges = list;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch colleges');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<College> getFilteredColleges() {
    if (searchText.isEmpty) {
      return colleges;
    } else {
      final List<College> filteredColleges = [];
      final Set<String> collegeNames = {};

      for (final college in colleges) {
        final name = college.name?.toLowerCase() ?? '';
        final stateProvince = college.stateProvince?.toLowerCase() ?? '';

        if (name.contains(searchText.toLowerCase()) ||
            stateProvince.contains(searchText.toLowerCase())) {

          if (!collegeNames.contains(name)) {
            filteredColleges.add(college);
            collegeNames.add(name);
          }
        }
      }

      return filteredColleges;
    }
  }

  void searchColleges(String query) {
    setState(() {
      searchText = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.white,
      drawer: const DrawerScreen(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.indigo,
        elevation: 0,
        title: const Text(
          "College Duniya",
          style: TextStyle(color: Colors.white, fontSize: 22.0),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.indigo,
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
            margin: EdgeInsets.zero,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: searchController,
                onChanged: searchColleges,
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Search',
                  prefixIcon: Icon(
                    Icons.search,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    shrinkWrap: true,
                    itemCount: getFilteredColleges().length,
                    itemBuilder: (context, index) {
                      final college = getFilteredColleges()[index];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CollegeDetailsScreen(
                                    college: college,
                                  )));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 12.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: const Color(0xFFf7cbe3).withOpacity(0.3),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8.0),
                            leading: const Icon(Icons.account_balance),
                            title: Flex(
                              direction: Axis.vertical,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  college.name.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  college.stateProvince.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
