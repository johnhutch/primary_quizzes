class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.text :body
      t.belongs_to :question_id

      t.timestamps
    end
  end
end
