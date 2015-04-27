require 'has_files/has_file/deffered_attachment_assignment'
require 'has_files/has_file/options_handling'


module HasFiles

  class HasFile < ActiveRecord::Base

    def self.initialize_attachment ( options = {} )

      styles = proc { | attachment | attachment.instance.association_styles }

      has_attached_file :attachment, options.merge( styles: styles )

      belongs_to :attachable, polymorphic: true

      validates_attachment :attachment, presence: true, file_type_ignorance: true

      delegate :url, to: :attachment

      include HasFiles::DefferedAttachmentAssigment

      include HasFiles::OptionsHandling

    end

  end

end
