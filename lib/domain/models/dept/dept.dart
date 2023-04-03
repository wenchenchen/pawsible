class Dept
{

  final String id;
  final String name;
  final String? parentId;
  final Dept? parentDept;

  factory Dept.fromJson(Map<String, dynamic> json) {
    return Dept(
      id: json['id'],
      name: json['name'],
      parentId: json['parent_id'],
      parentDept: json['parentDept'],
    );
  }

  Dept({required this.id, required this.name,required this.parentId,required this.parentDept});

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'parent_id': parentId,
    'parentDept':parentDept
  };

}