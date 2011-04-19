Factory.define :wiki do |f|
  f.paadal "twinkle twinkle little star"
end

Factory.define :user do |u|
  u.email 'a@b.com'
  u.password 'password'
end

Factory.define :wiki_version do |wv|
  wv.paadal "tamil paadal"
  wv.paadal_english "english paadal"
  wv.english_short_desc  "abcd"
  wv.tamil_short_desc "aaah eeeh"
  wv.tamil_long_desc "aaaaaaaaaaaah eeeeeeeeeeeeeeeeeh"
  wv.state "active"
  wv.association :user
  wv.association :wiki
  wv.version 1
end
