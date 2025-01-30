namespace :secondary do

  desc "Create a new secondary database with migration"
  task create: :environment do
    # Prompt for database details
    puts "first database: #{ActiveRecord::Base.connection.current_database}"
    puts "Enter the name for the new secondary database:"
    # name = STDIN.gets.chomp   
    currnet_user = User.last
    db_name = "secondary3"
    database = currnet_user.update(database_name: db_name)
    ActiveRecord::Base.connection.create_database(db_name)
    puts "Secondary database '#{db_name}' created successfully!"
    
    current_config = ActiveRecord::Base.connection_db_config.configuration_hash
    new_config = current_config.merge(database: db_name)
    ActiveRecord::Base.establish_connection(new_config)
    
    puts "Switched to database: #{ActiveRecord::Base.connection.current_database}"

    # secondary_migrate_dir = Rails.root.join("db", "secondary_migrate")
    # Dir.mkdir(secondary_migrate_dir) unless Dir.exists?(secondary_migrate_dir)
    # migration_context = ActiveRecord::MigrationContext.new(secondary_migrate_dir, ActiveRecord::SchemaMigration)
    # migration_context.migrate

    puts "#{database} migrated!"
    
    # ActiveRecord::Base.connection.create_database(database)
  rescue => e
    puts "Failed to create secondary database: #{e.message}"
  ensure
    ActiveRecord::Base.establish_connection(Rails.env.to_sym)
  end

  desc "Rollback migrations for the secondary database"
  task rollback_secondary: :environment do
    puts "Rolling back the secondary database..."

    # Establish connection to the secondary database programmatically
    ActiveRecord::Base.establish_connection(
      adapter: "postgresql",
      host: "localhost",
      database: "my_app_secondary_development",
      username: "postgres",
      password: "password",
      pool: ENV.fetch("RAILS_MAX_THREADS") { 5 }
    )

    # Rollback migrations from the secondary_migrate folder
    schema_migration = ActiveRecord::Base.connection.schema_migration
    migration_context = ActiveRecord::MigrationContext.new("db/secondary_migrate", schema_migration)
    # migration_context = ActiveRecord::MigrationContext.new(secondary_migrate_dir, schema_migration)
    migration_context.rollback

    puts "Secondary database rolled back!"
  end

  desc "migrate secondary database"
  task migrate_secondary: :environment do
    puts "migrate secondary database..."
    puts "old_database_task #{ActiveRecord::Base.connection.current_database}"

    Order
    secondary_migrate_dir = Rails.root.join("db", "secondary_migrate")
    # Dir.mkdir(secondary_migrate_dir) unless Dir.exists?(secondary_migrate_dir)
    schema_migration = ActiveRecord::Base.connection.schema_migration
    migration_context = ActiveRecord::MigrationContext.new(secondary_migrate_dir, schema_migration)
    migration_context.migrate
    # migration_context.rollback
    # ActiveRecord::Migrator.migrations_paths=("db/#{database_name}/")
    # ActiveRecord::Migrator.migrations_paths=("db/secondary_migrate")

  puts "new_database_task #{ActiveRecord::Base.connection.current_database}"

    puts "Secondary database testing done!"
    

  end
end
