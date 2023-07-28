class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Laptop, public: true

    return unless user.present?

    can :manage, Reservation, user_id: user.id
    can :manage, LaptopReservation, reservation: { user_id: user.id }
    can :read, Laptop

    return unless user.admin?

    can :manage, :all
  end
end
