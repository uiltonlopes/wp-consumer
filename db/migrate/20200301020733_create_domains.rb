class CreateDomains < ActiveRecord::Migration[6.0]
  def change
    create_table :domains do |t|
      t.string :name
      t.string :protocol
      t.string :host
      t.string :namespace

      t.timestamps
    end
  end
end
