class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  connects_to database: { writing: :primary, reading: :primary }
  puts "current_database1  #{ActiveRecord::Base.connection.current_database}"
  database_name = User.last.database_name
  current_user = User.last
  # database_name = Database.first.name
  begin
    current_config = ActiveRecord::Base.connection_db_config.configuration_hash
    new_config = current_config.merge(database: database_name)
    ActiveRecord::Base.establish_connection(new_config)
    ActiveRecord::Base.connection
  rescue ActiveRecord::NoDatabaseError
      puts "Database '#{database_name}' does not exist. Creating..."
      User.create_database(database_name,current_user)
      if  ActiveRecord::Base.connection
        p "working"
      else
        p "not"
      end
      puts "switch to new_database  #{ActiveRecord::Base.connection.current_database}"
  end
end
