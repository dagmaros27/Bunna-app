threshold = 10
regional_threshold = 3

class DataAnalysis:
    def __init__(self, database_handler):
        self.database_handler = database_handler
        self.result = {}

    def analyze_data(self):
        disease_counts = self.database_handler.fetch_report_disease_counts()
        region_counts = self.database_handler.fetch_report_region_counts()
        total_reports = self.database_handler.fetch_report_count()
        regional_disease_counts = (
            self.database_handler.fetch_report_regional_disease_counts()
        )

        self.result["total_reports"] = total_reports
        self.result["count_by_disease"] = self._count_by_disease(disease_counts)
        self.result["count_by_region"] = self._count_by_region(region_counts)
        self.result["prevalence_per_region"] = self._prevalence_per_region(
            regional_disease_counts
        )

        return self.result

    def _count_by_disease(self, disease_counts):
        disease_aggregate = {}
        for region, disease_name, count in disease_counts:
            if disease_name == "Healthy":
                continue
            else:
                if disease_name not in disease_aggregate:
                    disease_aggregate[disease_name] = 0
                disease_aggregate[disease_name] += count

        count_by_disease = []
        for disease_name, count in disease_aggregate.items():
            result = {
                "disease_name": disease_name,
                "count": count,
                "epidemic": True if count > threshold else False,
            }
            count_by_disease.append(result)
        return count_by_disease

    def _count_by_region(self, region_counts):
        region_aggregate = {}
        for region, count in region_counts:
            if region not in region_aggregate:
                region_aggregate[region] = 0
            region_aggregate[region] += count
        count_by_region = []
        for region, count in region_aggregate.items():
            result = {
                "region": region,
                "count": count,
                "epidemic": True if count > threshold else False,
            }
            count_by_region.append(result)
        return count_by_region

    def _prevalence_per_region(self, regional_disease_counts):
        prevalence_data = {}
        for disease_name, region, count in regional_disease_counts:
            if disease_name == "Healthy":
                continue
            else:
                if disease_name not in prevalence_data:
                    prevalence_data[disease_name] = []
                prevalence_data[disease_name].append({"region": region, "count": count})
        return prevalence_data