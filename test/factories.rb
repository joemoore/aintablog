Factory.sequence :url do |n|
  "http://#{n}/example.com"
end

Factory.sequence :permalink do |n|
  "permalink-to-#{n}"
end

Factory.define :user do |u|
  u.name "Bob Smith"
  u.email  "bob@example.com"
  u.salt "7e3041ebc2fc05a40c60028e2c4901a81035d3cd"
  u.crypted_password  "00742970dc9e6319f8019fd54864d3ea740f04b1" # test
  u.created_at  5.days.ago
end

Factory.define :article do |a|
  a.permalink {Factory.next(:permalink)}
  a.header "Article"
  a.content "I want to talk about myself"                                                                    
  a.cite {Factory.next(:url)}
  a.user {|user| user.association(:user) }
end


