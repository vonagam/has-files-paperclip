RSpec.describe HasFiles::DefferedAttachmentAssigment do

  subject( :klass ) { HasFiles::HasFile }

  before { clear_options }


  describe '#attachment=' do

    subject( :has_file ) {

      association = 'association'

      klass.add_association_options association, file_type_ignorance: true

      build :has_file, attachable_association: association

    }


    it 'no validation - no assignment' do

      expect( has_file.attachment? ).to be false

    end

    it 'apply assignment before validation' do

      expect { has_file.valid? }.to change { has_file.attachment? }.from( false ).to( true )

    end

  end

end
