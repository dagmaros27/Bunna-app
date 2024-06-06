class Analytics {
  int totalDiseaseReport;
  List<Disease> countByDisease;
  List<Region> countByRegion;
  Map<String, List<DiseasePrevalency>> prevalency;

  Analytics(
      {required this.countByDisease,
      required this.countByRegion,
      required this.totalDiseaseReport,
      required this.prevalency});

  factory Analytics.fromJson(Map<String, dynamic> json) {
    return Analytics(
      totalDiseaseReport: json['Total disease Report'],
      countByDisease: (json['Count by disease'] as List)
          .map((i) => Disease.fromJson(i))
          .toList(),
      countByRegion: (json['Count by region'] as List)
          .map((i) => Region.fromJson(i))
          .toList(),
      prevalency: (json['prevalency per region'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          (value as List).map((i) => DiseasePrevalency.fromJson(i)).toList(),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Total disease Report': totalDiseaseReport,
      'Count by disease': countByDisease.map((i) => i.toJson()).toList(),
      'Count by region': countByRegion.map((i) => i.toJson()).toList(),
      'prevalency per region': prevalency.map(
        (key, value) => MapEntry(key, value.map((i) => i.toJson()).toList()),
      ),
    };
  }
}

class Disease {
  String diseaseName;
  bool epidemic;
  int reported;

  Disease(
      {required this.diseaseName,
      required this.epidemic,
      required this.reported});

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      diseaseName: json['disease_name'],
      epidemic: json['epidemic'],
      reported: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'disease_name': diseaseName,
      'epidemic': epidemic,
      'count': reported,
    };
  }
}

class Region {
  String regionName;
  int reported;

  Region({required this.regionName, required this.reported});

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      regionName: json['region'],
      reported: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'region': regionName,
      'count': reported,
    };
  }
}

class DiseasePrevalency {
  final String disease;
  final int count;
  final String region;

  DiseasePrevalency({
    required this.disease,
    required this.count,
    required this.region,
  });

  factory DiseasePrevalency.fromJson(Map<String, dynamic> json) {
    return DiseasePrevalency(
      disease: json['disease'],
      count: json['count'],
      region: json['region'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'disease': disease,
      'count': count,
      'region': region,
    };
  }
}
