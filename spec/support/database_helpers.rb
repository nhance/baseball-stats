module DatabaseHelpers
  def init_db!
    File.delete(File.join(__dir__, '../../db/test.sqlite3')) # Hardcoded to save time
    BaseballStats::Application.new('test')
    migrations_dir = File.join(__dir__, '../../db/migrate/*.rb')
    ActiveRecord::Migrator.migrate migrations_dir
  end
end
