class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
        t.string :title
        t.integer :year
        t.string :description
        t.integer :user_id
        t.boolean :fetched_first
    end

  end
end
