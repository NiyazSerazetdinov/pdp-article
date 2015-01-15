FactoryGirl.define do
  factory :comment do
    text 'Cooment text'
    association :user
    association :article
  end
end
