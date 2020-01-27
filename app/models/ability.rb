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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    if user
      can :read, Team do |t|
        t.user_id == user.id || t.users.where(id: user.id).present?
      end

      can :destroy, Team, user_id: user.id

      can [:read, :create], Channel do |c|
        c.team.user_id == user.id || c.team.users.where(id: user.id).present?
      end

      can [:destroy, :update], Channel do |c|
        c.team.user_id == user.id || c.user_id == user.id
      end

      can [:read], Talk do |t|
        t.user_one_id == user.id || t.user_two_id == user.id
      end

      can [:create, :destroy], TeamUser do |t|
        t.team.user_id == user.id
      end
    end
  end
end
