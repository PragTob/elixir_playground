month_content = File.read!("timeular.json")
TimeularReportGenerator.create(month_content)
