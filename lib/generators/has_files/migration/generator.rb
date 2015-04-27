module HasFiles

  module Generators

    class Generator < Rails::Generators::Base

      include Rails::Generators::Migration
      

      desc 'Generates migration for HasFiles'

      source_root File.join( File.dirname( __FILE__ ), 'templates' )


      def create_migration_file

        migration_template 'create_has_files_table.rb', 'db/migrate/create_has_files_table.rb'

      end

    end

  end

end
