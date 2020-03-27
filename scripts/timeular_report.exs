month_content = File.read!("full_timeular.json")
TimeularReportGenerator.create(month_content)
