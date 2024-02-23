FactoryBot.define do
  factory :answer do
    selected_option { [true, false].sample }
    survey
    user
  end
end
