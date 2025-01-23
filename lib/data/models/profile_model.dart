class ProfileModel {
  final int id;
  final String email;
  final String login;
  final String firstName;
  final String lastName;
  final String usualFullName;
  final dynamic usualFirstName;
  final String url;
  final String phone;
  final String displayname;
  final String kind;
  final Map<String, dynamic> image;
  final bool? staff;
  final int correctionPoint;
  final String poolMonth;
  final String poolYear;
  final dynamic location;
  final int wallet;
  final String anonymizeDate;
  final String dataErasureDate;
  final String createdAt;
  final String updatedAt;
  final dynamic alumnizedAt;
  final bool? alumni;
  final bool? active;
  final List<dynamic> groups;
  final List<dynamic> cursusUsers;
  final List<dynamic> projectsUsers;
  final List<dynamic> languagesUsers;
  final List<dynamic> achievements;
  final List<dynamic> titles;
  final List<dynamic> titlesUsers;
  final List<dynamic> partnerships;
  final List<dynamic> patroned;
  final List<dynamic> patroning;
  final List<dynamic> expertisesUsers;
  final List<dynamic> roles;
  final List<dynamic> campus;
  final List<dynamic> campusUsers;

  ProfileModel({
    required this.id,
    required this.email,
    required this.login,
    required this.firstName,
    required this.lastName,
    required this.usualFullName,
    this.usualFirstName,
    required this.url,
    required this.phone,
    required this.displayname,
    required this.kind,
    required this.image,
    this.staff,
    required this.correctionPoint,
    required this.poolMonth,
    required this.poolYear,
    this.location,
    required this.wallet,
    required this.anonymizeDate,
    required this.dataErasureDate,
    required this.createdAt,
    required this.updatedAt,
    this.alumnizedAt,
    this.alumni,
    this.active,
    required this.groups,
    required this.cursusUsers,
    required this.projectsUsers,
    required this.languagesUsers,
    required this.achievements,
    required this.titles,
    required this.titlesUsers,
    required this.partnerships,
    required this.patroned,
    required this.patroning,
    required this.expertisesUsers,
    required this.roles,
    required this.campus,
    required this.campusUsers,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      email: json['email'],
      login: json['login'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      usualFullName: json['usual_full_name'],
      usualFirstName: json['usual_first_name'],
      url: json['url'],
      phone: json['phone'] ?? 'Hidden',
      displayname: json['displayname'] ?? json['login'],
      kind: json['kind'],
      image: json['image'],
      staff: json['staff'] ?? false,
      correctionPoint: json['correction_point'] ?? 0,
      poolMonth: json['pool_month'],
      poolYear: json['pool_year'],
      location: json['location'] ?? 'Not available',
      wallet: json['wallet'],
      anonymizeDate: json['anonymize_date'],
      dataErasureDate: json['data_erasure_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      alumnizedAt: json['alumnized_at'],
      alumni: json['alumni'],
      active: json['active'],
      groups: json['groups'] ?? [],
      cursusUsers: json['cursus_users'] ?? [],
      projectsUsers: json['projects_users'] ?? [],
      languagesUsers: json['languages_users'] ?? [],
      achievements: json['achievements'] ?? [],
      titles: json['titles'] ?? [],
      titlesUsers: json['titles_users'] ?? [],
      partnerships: json['partnerships'] ?? [],
      patroned: json['patroned'] ?? [],
      patroning: json['patroning'] ?? [],
      expertisesUsers: json['expertises_users'] ?? [],
      roles: json['roles'] ?? [],
      campus: json['campus'] ?? [],
      campusUsers: json['campus_users'] ?? [],
    );
  }
}
