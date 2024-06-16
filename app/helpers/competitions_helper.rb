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
      '<svg class="w-3 h-3 inline-block" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512">
        <path fill="#ef4444" d="M214.6 41.4c-12.5-12.5-32.8-12.5-45.3 0l-160 160c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0L160 141.2V448c0 17.7 14.3 32 32 32s32-14.3 32-32V141.2L329.4 246.6c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3l-160-160z"/>
      </svg>'
    when number.negative? then
      '<svg class="w-3 h-3 inline-block" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512">
        <path fill="#2563eb" d="M169.4 470.6c12.5 12.5 32.8 12.5 45.3 0l160-160c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L224 370.8 224 64c0-17.7-14.3-32-32-32s-32 14.3-32 32l0 306.7L54.6 265.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l160 160z"/>
      </svg>'
    when number.zero? then
      '<svg class="w-3 h-3 inline-block" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512">
        <path fill="#ea580c" d="M438.6 278.6c12.5-12.5 12.5-32.8 0-45.3l-160-160c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L338.8 224 32 224c-17.7 0-32 14.3-32 32s14.3 32 32 32l306.7 0L233.4 393.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0l160-160z"/>
      </svg>&nbsp;'
    end
  end
end
