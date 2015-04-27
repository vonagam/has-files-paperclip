class CreateHasFilesTable < ActiveRecord::Migration

  def change

    create_table :has_files do | t |

      t.string :attachable_association
      
      t.attachment :attachment

      t.references :attachable, polymorphic: true, index: true

      t.index [ :attachable_type, :attachable_id, :attachable_association ], name: 'full_association_index_of_has_files'

    end

  end

end
