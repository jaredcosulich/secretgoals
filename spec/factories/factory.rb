Factory.sequence :email do |n|
  "person#{n}@example.com"
end

Factory.define :user do |f|
  f.email {Factory.next :email}
  f.password "password"
  f.password_confirmation "password"
end

Factory.define :goal do |f|
end

Factory.define :tag do |f|
end

Factory.define :user_goal do |f|
  f.association :user
end
