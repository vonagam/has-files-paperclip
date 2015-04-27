module HasFiles

  module OptionsHandling

    class AssociationError < StandardError; end


    extend ActiveSupport::Concern


    class_methods do

      def add_association_options ( association, options )

        styles = options.clone

        validations = {

          Paperclip::Validators::AttachmentSizeValidator => styles.extract!( *Paperclip::Validators::AttachmentSizeValidator::AVAILABLE_CHECKS ),

          Paperclip::Validators::AttachmentFileTypeIgnoranceValidator => styles.extract!( :file_type_ignorance ),

          Paperclip::Validators::AttachmentContentTypeValidator => styles.extract!( :content_type )

        }

        validations.reject! { | k, v | v.empty? }

        validations.each { | k, v | v[ :attributes ] = :attachment }

        if ( validations.keys & Paperclip::REQUIRED_VALIDATORS ).empty?

          raise Paperclip::Errors::MissingRequiredValidatorError

        end

        if OPTIONS.has_key? association

          raise AssociationError, "HasFile already has association with name #{ association }"

        end

        OPTIONS[ association ] = { styles: styles, validations: validations }

      end

    end
    

    included do

      validate :validate_attachment
      

      def association_styles

        association_options[ :styles ]

      end

      protected

      OPTIONS = {}

      def validate_attachment

        association_options[ :validations ].each do | validator_class, options |

          validator_class.new( options.clone ).validate self

        end

      end

      def association_options

        options = OPTIONS[ attachable_association ]

        if options.nil?

          if attachable_association.blank?

            raise AssociationError, 'HasFile require setted association.'

          else

            raise AssociationError, "HasFile can't find #{ attachable_association } options"

          end

        end

        options

      end

    end

  end

end
