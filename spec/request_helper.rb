def clean!(tables=false)
  # this will clean the specified database tables
  #   add the table names that you have to clean! by default.
  #   usually, this array should contain all tables.
  tables ||=  %w{users screams}
                  
  tables.each do |table|
    ActiveRecord::Base.connection.execute("TRUNCATE #{table};")
  end
end