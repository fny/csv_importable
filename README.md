# CsvImportable

Import CSVs with ActiveModel goodness.

## Installation

Add this line to your application's Gemfile:

    gem 'csv_importable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csv_importable

## Usage

```ruby
class Student < ActiveRecord::Base
  include CsvImportable
end

Student.import_csv('filename') # Defaults to using a transaction
Student.import_csv('filename', transaction: false) # Much slower

require 'active-import'
Student.import_csv('filename') # Uses ActiveImport by default if you're using it

csv_import = Student.import_csv('path/to/file')
csv_import.errors # => Gives you an ActiveModel::Errors object

# You can also create play with your own imports without saving:
import = CsvImportable::CsvImport.new(Student, 'path/to/file')
import.valid? # => true
import.executed? # => false
import.save # => true

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
