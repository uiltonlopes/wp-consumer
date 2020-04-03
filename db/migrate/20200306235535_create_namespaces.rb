class CreateNamespaces < ActiveRecord::Migration[6.0]
  def change
    create_table :namespaces do |t|
      t.string :namespace

      t.timestamps
    end
  end
end
