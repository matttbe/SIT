class AddSuperadminToUser < ActiveRecord::Migration
  def up
    add_column :users, :superadmin, :boolean,
                                    :null => false,
                                    :default => false
    User.create! do |r|
      r.email      = 'maitre@dieu.ciel'
      r.password   = 'password'
      r.superadmin = true
    end
  end

  def down
    remove_column :users, :superadmin
    User.find_by_email('maitre@dieu.ciel').try(:delete)
  end
end