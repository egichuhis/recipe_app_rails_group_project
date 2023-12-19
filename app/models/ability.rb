class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :manage, Food, user_id: user.id
      can :manage, Recipe, user_id: user.id
      can :manage, RecipesFood, recipe: { user_id: user.id }
      can :read, :all
    end
  end
end
