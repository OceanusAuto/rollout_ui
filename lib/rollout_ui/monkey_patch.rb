class Rollout
  alias_method :original_active?, :active?

  ## adddind user=nil for allowing backward compatibility, rollout 1.2.0 optional param
  def active?(feature, user=nil)
    RolloutUi::Wrapper.new(self).add_feature(feature)
    original_active?(feature, user)
  end
end
