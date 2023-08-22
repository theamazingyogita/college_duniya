// class College {
//   final dynamic name;
//   final dynamic country;
//   final dynamic stateProvince;
//   final List<dynamic>? domains;
//   final List<dynamic>? webPages;
//
//   College({
//     this.name,
//     this.country,
//     this.stateProvince,
//     this.domains,
//     this.webPages,
//   });
//
//   factory College.fromJson(Map<String, dynamic> json) {
//     return College(
//       name: json['name'],
//       country: json['country'],
//       stateProvince: json['state-province'],
//       domains:
//           json['domains'] != null ? List<String>.from(json['domains']) : null,
//       webPages: json['web_pages'] != null
//           ? List<String>.from(json['web_pages'])
//           : null,
//     );
//   }
// }

class College {
  String? country;
  List<String>? domains;
  String? alphaTwoCode;
  String? stateProvince;
  List<String>? webPages;
  String? name;

  College({
    this.country,
    this.domains,
    this.alphaTwoCode,
    this.stateProvince,
    this.webPages,
    this.name,
  });

  College.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    domains = json['domains'].cast<String>();
    alphaTwoCode = json['alpha_two_code'];
    stateProvince = json['state-province'];
    webPages = json['web_pages'].cast<String>();
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['domains'] = domains;
    data['alpha_two_code'] = alphaTwoCode;
    data['state-province'] = stateProvince;
    data['web_pages'] = webPages;
    data['name'] = name;
    return data;
  }
}
