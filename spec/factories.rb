Factory.define :wiki do |w|
  w.paadal "twinkle twinkle little star"
  w.paadal_english "english paadal"
  w.english_short_desc "abcd"
  w.tamil_short_desc "aaah eeeh"
  w.tamil_long_desc "aaaaaaaaaaaah eeeeeeeeeeeeeeeeeh"
end

Factory.define :user do |u|
  u.email 'a@b.com'
  u.password 'password'
end

Factory.define :wiki_version do |wv|
  wv.paadal "twinkle twinkle little star"
  wv.paadal_english "english paadal"
  wv.english_short_desc "abcd"
  wv.tamil_short_desc "aaah eeeh"
  wv.tamil_long_desc "aaaaaaaaaaaah eeeeeeeeeeeeeeeeeh"
  wv.association :user
  wv.association :wiki
  wv.version 1
  wv.state "draft"
end
