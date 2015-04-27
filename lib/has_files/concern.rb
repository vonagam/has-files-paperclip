module HasFiles

  module Concern

    extend ActiveSupport::Concern

    class_methods do

      def has_file ( name, options = {} )

        add_files_association :has_one, name, options

      end

      def has_files ( names, options = {} )

        add_files_association :has_many, names, options

      end

      private

      def add_files_association ( type, name, options )

        association = "#{ self.name }:#{ name }"

        HasFiles::HasFile.add_association_options association, options

        self.send(
          type,
          name,
          -> { where attachable_association: association },
          class_name: 'HasFiles::HasFile',
          as: :attachable,
          dependent: :destroy
        )

      end

    end

  end

end
