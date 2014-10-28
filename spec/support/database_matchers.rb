RSpec::Matchers.define :have_db_column do |column_name|
  match do |ar_object|
    ar_object.class.column_names.include?(column_name.to_s)
  end
end
