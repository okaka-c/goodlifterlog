module CompetitionsHelper
  def weight_classes_for(user)
    user.profile.gender == 'man' ? Competition::WEIGHT_CLASSES['男子'] : Competition::WEIGHT_CLASSES['女子']
  end

  def subtraction_result_color(number)
    case
    when number.positive? then "bg-red-50 text-red-600"
    when number.negative? then "bg-blue-50 text-blue-600"
    when number.zero? then "bg-orange-50 text-orange-600"
    end
  end

  def subtraction_result_allow(number)
    case
    when number.positive? then
      '<svg class="w-3 h-3 inline-block" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512">
        <path fill="#ef4444" d="M256 80c0-17.7-14.3-32-32-32s-32 14.3-32 32V224H48c-17.7 0-32 14.3-32 32s14.3 32 32 32H192V432c0 17.7 14.3 32 32 32s32-14.3 32-32V288H400c17.7 0 32-14.3 32-32s-14.3-32-32-32H256V80z"/>
      </svg>&nbsp;'
    when number.negative? then
      '<svg class="w-3 h-3 inline-block" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512">
        <path fill="#2563eb" d="M432 256c0 17.7-14.3 32-32 32L48 288c-17.7 0-32-14.3-32-32s14.3-32 32-32l352 0c17.7 0 32 14.3 32 32z"/>
      </svg>&nbsp;'
    when number.zero? then
      '<svg class="w-3 h-3 inline-block" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512">
        <path fill="#ea580c" d="M224 32c0-17.7-14.3-32-32-32s-32 14.3-32 32V144H48c-17.7 0-32 14.3-32 32s14.3 32 32 32H160V320c0 17.7 14.3 32 32 32s32-14.3 32-32V208H336c17.7 0 32-14.3 32-32s-14.3-32-32-32H224V32zM0 480c0 17.7 14.3 32 32 32H352c17.7 0 32-14.3 32-32s-14.3-32-32-32H32c-17.7 0-32 14.3-32 32z"/>
      </svg>&nbsp;'
    end
  end
end
