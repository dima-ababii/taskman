class Ability
  include CanCan::Ability

  def initialize(user)
    # Define User abilities
    can :manage, :all if user.role == 'teacher'
    
    if user.role == 'student'
      can :read, Task
      can :manage, User, id: user.id
    end
  end
end
