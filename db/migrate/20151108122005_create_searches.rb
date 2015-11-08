class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :keyword
      t.string :course_name
      t.string :course_url
      t.string :course_id
      t.string :course_date
      t.timestamps null:false
    end
  end
end
