# Rails.application.config.to_prepare do
#   # Executes during application initialization
#   begin
#     # Load the first user's database configuration
#     database_name = User.first&.database_name
#     puts "database_name #{database_name}"
#     if database_name.present?
#       current_config = ActiveRecord::Base.connection_db_config.configuration_hash
#       new_config = current_config.merge(database: database_name)

#       # Establish a connection to the user's database
#       ActiveRecord::Base.establish_connection(new_config)

#       puts "Switched to secondary database: #{ActiveRecord::Base.connection.current_database}"
#     else
#       puts "No User found or no database name available. Staying on primary database."
#     end
#   rescue => e
#     # Handle errors during initialization
#     puts "Error during dynamic database connection: #{e.message}"
#   end
# end
