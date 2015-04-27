ActiveRecord::Schema.define do

  create_table :has_files, force: true do | t |

    t.references :attachable, polymorphic: true, index: true
    t.string :attachable_association
    t.attachment :attachment

    t.index [ :attachable_type, :attachable_id, :attachable_association ], name: 'full_association_index_of_has_files'

  end

  create_table :attachments do | t |

    t.references :has_file, index: true
    t.string :style
    t.binary :file_contents

  end

  create_table :models, force: true do | t |

    t.string :type

  end

end
