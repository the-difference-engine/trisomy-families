class CreateSchoolTherapies < ActiveRecord::Migration[5.0]
  def change
    create_table :school_therapies do |t|

      t.timestamps
    end
  end
end
