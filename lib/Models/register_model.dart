class RegisterModal {
  final String? id;
  final String name;
  final String gender;
  final String workexp;
  final String worktitle;
  final String aadharno;
  final String state;
  final String address;
  final String mobile;
  final String email;
  final String skills;
  final String workin;

  const RegisterModal({
    this.id,
    required this.name,
    required this.gender,
    required this.workexp,
    required this.worktitle,
    required this.aadharno,
    required this.state,
    required this.address,
    required this.mobile,
    required this.email,
    required this.skills,
    required this.workin,
  });
  tojson() {
    return {
      "name": name,
      "gender": gender,
      "work": workexp,
      "worktitle": worktitle,
      "aadharno": aadharno,
      "state": state,
      "address": address,
      "mobile": mobile,
      "email": email,
      "skills": skills,
      "workin": workin,
    };
  }
}
