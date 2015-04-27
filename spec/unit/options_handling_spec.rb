RSpec.describe HasFiles::OptionsHandling do

  let( :klass ) { HasFiles::HasFile }

  let( :association ) { 'existing' }

  let( :error ) { HasFiles::OptionsHandling::AssociationError }

  before { clear_options }


  describe '.add_association_options' do

    let( :method ) { klass.method :add_association_options }


    it 'both "content_type" and "file_type_ignorance" are absent - error' do

      expect { method.call( association, {} ) }.to raise_error Paperclip::Errors::MissingRequiredValidatorError

    end

    it '"content_type" is present - no error' do

      expect { method.call( association, content_type: 'application/pdf' ) }.not_to raise_error

    end

    it '"file_type_ignorance" is present - no error' do

      expect { method.call( association, file_type_ignorance: true ) }.not_to raise_error

    end

    it 'names duplication - error' do

      method.call association, file_type_ignorance: true

      expect { method.call association, file_type_ignorance: true }.to raise_error error

    end

  end

  describe '#association_styles' do

    let( :style ) { { origin: '10x10' } }

    subject( :has_file ) {

      klass.add_association_options association, style.merge( file_type_ignorance: true )

      build :has_file

    }


    it 'no attachable_association - error' do

      expect { has_file.association_styles }.to raise_error error, 'HasFile require setted association.'

    end

    it 'unknown attachable_association - error' do

      association = 'unknown'

      has_file.attachable_association = association

      expect { has_file.association_styles }.to raise_error error, "HasFile can't find #{ association } options"

    end

    it 'return style setted by .add_association_options' do

      has_file.attachable_association = association

      expect( has_file.association_styles ).to eq style

    end

  end

end
