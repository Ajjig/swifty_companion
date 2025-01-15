class ProfileModel {
  final int id;
  final String email;
  final String login;
  final String first_name;
  final String last_name;
  final String usual_full_name;
  final dynamic usual_first_name;
  final String url;
  final String phone;
  final String displayname;
  final String kind;
  final Map<String, dynamic> image;
  final bool? staff;
  final int correction_point;
  final String pool_month;
  final String pool_year;
  final dynamic location;
  final int wallet;
  final String anonymize_date;
  final String data_erasure_date;
  final String created_at;
  final String updated_at;
  final dynamic alumnized_at;
  final bool? alumni;
  final bool? active;
  final List<dynamic> groups;
  final List<dynamic> cursus_users;
  final List<dynamic> projects_users;
  final List<dynamic> languages_users;
  final List<dynamic> achievements;
  final List<dynamic> titles;
  final List<dynamic> titles_users;
  final List<dynamic> partnerships;
  final List<dynamic> patroned;
  final List<dynamic> patroning;
  final List<dynamic> expertises_users;
  final List<dynamic> roles;
  final List<dynamic> campus;
  final List<dynamic> campus_users;

  ProfileModel({
    required this.id,
    required this.email,
    required this.login,
    required this.first_name,
    required this.last_name,
    required this.usual_full_name,
    this.usual_first_name,
    required this.url,
    required this.phone,
    required this.displayname,
    required this.kind,
    required this.image,
    this.staff,
    required this.correction_point,
    required this.pool_month,
    required this.pool_year,
    this.location,
    required this.wallet,
    required this.anonymize_date,
    required this.data_erasure_date,
    required this.created_at,
    required this.updated_at,
    this.alumnized_at,
    this.alumni,
    this.active,
    required this.groups,
    required this.cursus_users,
    required this.projects_users,
    required this.languages_users,
    required this.achievements,
    required this.titles,
    required this.titles_users,
    required this.partnerships,
    required this.patroned,
    required this.patroning,
    required this.expertises_users,
    required this.roles,
    required this.campus,
    required this.campus_users,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      email: json['email'],
      login: json['login'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      usual_full_name: json['usual_full_name'],
      usual_first_name: json['usual_first_name'],
      url: json['url'],
      phone: json['phone'],
      displayname: json['displayname'],
      kind: json['kind'],
      image: json['image'],
      staff: json['staff'],
      correction_point: json['correction_point'],
      pool_month: json['pool_month'],
      pool_year: json['pool_year'],
      location: json['location'],
      wallet: json['wallet'],
      anonymize_date: json['anonymize_date'],
      data_erasure_date: json['data_erasure_date'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      alumnized_at: json['alumnized_at'],
      alumni: json['alumni'],
      active: json['active'],
      groups: json['groups'] ?? [],
      cursus_users: json['cursus_users'] ?? [],
      projects_users: json['projects_users'] ?? [],
      languages_users: json['languages_users'] ?? [],
      achievements: json['achievements'] ?? [],
      titles: json['titles'] ?? [],
      titles_users: json['titles_users'] ?? [],
      partnerships: json['partnerships'] ?? [],
      patroned: json['patroned'] ?? [],
      patroning: json['patroning'] ?? [],
      expertises_users: json['expertises_users'] ?? [],
      roles: json['roles'] ?? [],
      campus: json['campus'] ?? [],
      campus_users: json['campus_users'] ?? [],
    );
  }
}
