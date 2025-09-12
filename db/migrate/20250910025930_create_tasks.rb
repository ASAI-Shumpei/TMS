class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :subject
      t.text :detail
      t.datetime :due_date
      t.integer :status

      t.timestamps
    end
  end
end
