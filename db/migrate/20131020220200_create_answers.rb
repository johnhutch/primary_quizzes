class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :question_id, index: true
      t.integer :user_id, index: true

      t.timestamps
    end
  end
end
