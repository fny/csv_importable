require 'csv'
require 'csv_importable/version'
require 'csv_importable/csv_import'

module CsvImportable
  def import_csv(file_path)
    csv_import = CsvImport.new(self, file_path)
    csv_import.save
    csv_import
  end
end
