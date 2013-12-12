class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    # With Rolify: https://github.com/EppO/rolify/wiki/Tutorial

    if user.nil? # not logged in
      return
    end
    if user.has_role? :superadmin
      can :read, :all
      can :manage, :all
      can :destroy, :all
    else
      cannot :read, ActiveAdmin::Page, :name => "Dashboard"

      can :read, User
      can :manage, User, :id => user.id
      if user.has_role? :users_admin
        can :manage, ActiveAdmin::Page, :name => "Users"
      else
        cannot :read, ActiveAdmin::Page, :name => "Users"
      end

      if user.has_role? :orga_admin
        can :manage, Organisation
        can :manage, ActiveAdmin::Page, :name => "Organisations"
      else
        manage_orga = false
        user.own_organisations.each do |orga|
          can :manage, orga
          manage_orga = true
        end
        user.organisations.each do |orga|
          can :update, orga
          manage_orga = true
        end
        if manage_orga
          can :read, ActiveAdmin::Page, :name => "Organisations"
        else
          cannot :read, ActiveAdmin::Page, :name => "Organisations"
        end
      end

      if user.has_role? :serv_admin
        can :manage, Service
        can :manage, ActiveAdmin::Page, :name => "Services"
      else
        services = user.own_services
        if services.nil? or services.empty?
          cannot :read, ActiveAdmin::Page, :name => "Services"
        else
          services.each do |serv|
            can :manage, serv
          end
        end
      end
    end

  end
end
