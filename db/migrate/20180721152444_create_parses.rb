class CreateParses < ActiveRecord::Migration[5.1]
  def change
    create_table :parses do |t|

      t.timestamps
    end
  end
end
