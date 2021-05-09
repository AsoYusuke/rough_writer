class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.integer "user_id", null: false
      t.string "good", null: false
      t.string "bad", null: false
      t.timestamps
    end
  end
end
