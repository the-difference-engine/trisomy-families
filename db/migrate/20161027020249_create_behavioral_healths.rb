class CreateBehavioralHealths < ActiveRecord::Migration[5.0]
  def change
    create_table :behavioral_healths do |t|
      t.boolean :add
      t.boolean :adhd
      t.boolean :bipolar
      t.boolean :autism_spectrum
      t.boolean :depression
      t.boolean :anxiety_disorder
      t.boolean :ocd
      t.boolean :schizophrenia
      t.boolean :addictions
      t.boolean :personality_disorder
      t.boolean :eating_disorder
      t.boolean :odd
      t.boolean :conduct_disorder
      t.boolean :other
      t.boolean :none
      t.boolean :learning_disability
      t.boolean :global_developmental_delay
      t.boolean :intellectual_disability
      t.boolean :speech_delay
      t.boolean :receptive_delay
      t.boolean :expressive_delay
      t.boolean :auditory_processing_disorder
      t.boolean :apraxia_dyspraxia
      t.boolean :visual_processing
      t.string :other
      t.boolean :none

      t.timestamps
    end
  end
end
