month_content = File.read!("timeular_october.json")
TimeularReportGenerator.create(month_content)
