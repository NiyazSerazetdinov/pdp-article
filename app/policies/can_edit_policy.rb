class CanEditPolicy
  def initialize(owner, potential_owner)
    @owner, @potential_owner = owner, potential_owner
  end

  def allowed?
    @owner == @potential_owner
  end
end
