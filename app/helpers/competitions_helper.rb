module CompetitionsHelper
  def weight_classes_for(user)
    user.profile.gender == 'man' ? Competition::WEIGHT_CLASSES['男子'] : Competition::WEIGHT_CLASSES['女子']
  end
end
