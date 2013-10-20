class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :body
      t.integer :solution_id
      t.belongs_to :category_id
      t.belongs_to :user_id
      t.integer :elo, :null => false, :default => 1200

      t.timestamps
    end
  end
end
