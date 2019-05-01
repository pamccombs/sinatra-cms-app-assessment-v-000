class CreateLipsticks < ActiveRecord::Migration
  def change
    create_table :lipsticks do |t|
      t.integer :user_id
      t.string :color_scheme_main
      t.string :color_scheme_undertone
      t.string :name_of_lipstick
      t.string :finish
      t.string :dryness
      t.string :requires_a_base
      t.string :longevity
      t.string :brand
      t.string :difficulty_to_apply
      t.string :difficulty_to_remove
      t.string :oil_or_water_removal
    end
  end
end