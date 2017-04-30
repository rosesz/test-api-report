class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.string :comment
      t.datetime :generated_at

      t.timestamps
    end
  end
end
