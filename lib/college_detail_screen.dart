import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'college_model.dart';

class CollegeDetailsScreen extends StatefulWidget {
  final College college;

  const CollegeDetailsScreen({super.key, required this.college});

  @override
  State<CollegeDetailsScreen> createState() => _CollegeDetailsScreenState();
}

class _CollegeDetailsScreenState extends State<CollegeDetailsScreen> {
  Future<void> _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      const SnackBar(
          backgroundColor: Colors.deepPurpleAccent,
          content: Text(
            "There is some error launching the url",
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 1),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          child: Card(
            elevation: 0.2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFC5D9FF).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    commonCardWidget(
                      "Name",
                      "${widget.college.name}",
                    ),
                    commonCardWidget(
                      "Country",
                      "${widget.college.country}",
                    ),
                    commonCardWidget(
                      "State",
                      "${widget.college.stateProvince}".toString() == "null"
                          ? '-------'
                          : "${widget.college.stateProvince}",
                    ),
                    commonCardWidget(
                      "Domains",
                      '${widget.college.domains?.join(", ")}',
                    ),
                    commonCardWidget(
                      "Web Pages",
                      "${widget.college.webPages?[0]}",
                      isWebPage: true,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget commonCardWidget(
    dynamic title,
    dynamic value, {
    bool isWebPage = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.indigo,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2.0),
          InkWell(
            onTap: () => _launchURL(Uri.parse(value)),
            child: Text(
              value,
              style: isWebPage
                  ? const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                    )
                  : const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
            ),
          ),
          const SizedBox(height: 4.0),
        ],
      ),
    );
  }
}
