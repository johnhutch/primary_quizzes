class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end

    # Populate with our three categories for now
    Category.create :name => "HTML"
    Category.create :name => "CSS"
    Category.create :name => "Ruby on Rails"
  end
end
