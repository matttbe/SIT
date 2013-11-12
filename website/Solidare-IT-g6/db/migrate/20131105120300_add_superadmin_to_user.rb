class AddSuperadminToUser < ActiveRecord::Migration
  def up
    add_column :users, :superadmin, :boolean,
                                    :null => false,
                                    :default => false
    User.create! do |r|
      r.email      = 'maitre@dieu.ciel'
      r.password   = 'password'
      r.password_confirmation = 'password'
      r.name       = "Dieu"
      r.firstname  = "Maitre"
      r.birthdate  = 'TMon, 18 Jun 1990 15:00:00 UTC +00:00'
      r.karma      = 0
      r.id_ok      = false
      r.language   = 'us'
      r.superadmin = true
    end
  end

  def down
    remove_column :users, :superadmin
    User.find_by_email('maitre@dieu.ciel').try(:delete)
  end
end
