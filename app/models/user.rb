class User < ApplicationRecord

  def self.create_database(database_name,current_user)
    puts 
    # current_config = ActiveRecord::Base.connection_db_config.configuration_hash
    # admin_config = current_config.except(:database) # Exclude the database name
    # ActiveRecord::Base.establish_connection(admin_config)
  
    # # Create the database
    # ActiveRecord::Base.connection.create_database(database_name)
    puts "Database user '#{database_name}' created successfully."

    # current_user = User.last.database_name
    puts "current_user #{current_user.database_name}"
    # db_name = "secondary3"
    # database = current_user.update(database_name: db_name)
    # ActiveRecord::Base.connection.create_database(db_name)
    # puts "Secondary database '#{db_name}' created successfully!"
    
    # current_config = ActiveRecord::Base.connection_db_config.configuration_hash
    # new_config = current_config.merge(database: db_name)
    # ActiveRecord::Base.establish_connection(new_config)
    
    # puts "Switched to database: #{ActiveRecord::Base.connection.current_database}"

    # secondary_migrate_dir = Rails.root.join("db", "secondary_migrate")
    # Dir.mkdir(secondary_migrate_dir) unless Dir.exists?(secondary_migrate_dir)
    # migration_context = ActiveRecord::MigrationContext.new(secondary_migrate_dir, ActiveRecord::SchemaMigration)
    # migration_context.migrate

  end
end
