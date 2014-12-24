FactoryGirl.define do
  factory :article do
    title 'Title'
    text 'Text'
    association :user
  end
end
