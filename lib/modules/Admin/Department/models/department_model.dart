class DepartmentModel{
   String Department ;
   String Name ;
   String  Positon ;

   DepartmentModel({required this.Department, required this.Name, required this.Positon});

   factory DepartmentModel.fromJson(Map<String, dynamic> json) {
     return DepartmentModel(
       Department: json['department'],
       Name: json['name'],
       Positon: json['position'],
     );
   }

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = <String, dynamic>{};
     data['department'] = Department;
     data['name'] = Name;
     data['position'] = Positon;
     return data;
   }
}