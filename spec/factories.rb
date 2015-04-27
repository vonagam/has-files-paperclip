FactoryGirl.define do

  factory :has_file, class: HasFiles::HasFile do

    attachment File.open( File.join( Dir.pwd, 'spec/images', 'random.png' ) )
    
  end

end
