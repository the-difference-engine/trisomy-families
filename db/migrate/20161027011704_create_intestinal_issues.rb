class CreateIntestinalIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :intestinal_issues do |t|
      t.boolean :duodenal_atresia_stenosis_web
      t.boolean :anal_stenosis_atresia
      t.boolean :esophageal_atresia
      t.boolean :hirschsprung_disease
      t.boolean :chronic_constipation
      t.boolean :dysphagia
      t.boolean :aspiration 
      t.boolean :chronic_diarrhea
      t.boolean :pyloric_stenosis 
      t.boolean :gastroesophageal_reflux
      t.boolean :pepticulcers_gallstones
      t.boolean :hemorrhoids
      t.boolean :diverticulitis_diverticulosis
      t.boolean :colorectal_carcinoma
      t.boolean :ibs

      t.timestamps
    end
  end
end
