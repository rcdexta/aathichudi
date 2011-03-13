Factory.define :wiki do |f|
  f.paadal "twinkle twinkle little star"
  f.state "draft"
end

Factory.define :active_wiki, :parent => :wiki do |f|
  f.state 'active'
end
