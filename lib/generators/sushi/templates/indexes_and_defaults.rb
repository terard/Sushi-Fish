class IndexesAndDefaults < ActiveRecord::Migration
  def self.up
    change_column_default :pages, :show_in_nav, true
    add_index :pages, :ancestry
  end

  def self.down
    change_column_default :pages, :show_in_nav, nil
    remove_index :pages, :ancestry
  end
end