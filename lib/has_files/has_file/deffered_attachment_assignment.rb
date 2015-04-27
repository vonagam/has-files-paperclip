module HasFiles

  module DefferedAttachmentAssigment

    extend ActiveSupport::Concern
    

    included do

      before_validation :assign_deferred_attachment

      def attachment= ( value )

        @deffered_attachment = value

      end

      protected

      def assign_deferred_attachment

        return unless instance_variable_defined? :@deffered_attachment

        attachment.assign remove_instance_variable :@deffered_attachment

        return # because of before filter

      end

    end

  end

end
