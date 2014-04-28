module CsvImportable

  # TODO Add overwriting based on a query that returns a unique result
  # TODO Allow opting out of ID overrides
  class CsvImport
    extend ActiveModel::Model

    attr_reader :filename, :model, :errors

    def initialize(model, filename, options = {})
      @options = options
      @options[:transaction] ||= true
      @model = model
      @filename = filename
      @executed = false
      @errors = ActiveModel::Errors.new(self)
    end

    def imported_records
      @imported_records ||= load_imported_records
    end

    def load_imported_records
      imported_records = []
      begin
        CSV.foreach(filename, headers: true, skip_blanks: true) do |row|
          hashed_row = row.to_hash
          record = model.where(id: hashed_row['id']).first || model.new
          record.attributes = hashed_row
          imported_records << record
        end
      rescue ActiveRecord::UnknownAttributeError => e
        errors.add :base, "Invalid header. #{e.message}"
      end
      imported_records
    end

    def executed?
      @executed || false
    end

    def save
      if valid? && !executed?
        if defined?(ActiveRecord::Import)
          model.import(imported_records)
        elsif options[:trasaction]
          ActiveRecord::Base.transaction do
            imported_records.each(&:save!)
          end
        else
          imported_records.each(&:save!)
        end
        @executed = true
      end
    end

    def valid?
      return @valid if defined? @valid
      if imported_records.nil?
        errors.add :base, "Nothing to import!"
      else
        imported_records.each_with_index do |record, index|
          unless record.valid?
            record.errors.full_messages.each do |message|
              errors.add :base, "Row #{index + 1}: #{message}"
            end
          end
        end
      end
      @valid = !errors.any?
    end

  end

end