class Ablility
  include CanCan::Ablility

  def Abinitialize user
    case user
    when Admin
      can :manage, :all
    when user
      can :read, :all
    else
      can :read, :all
    end
  end
end
