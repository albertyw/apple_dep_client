SimpleCov.start do
  add_filter '/spec/'
  add_filter '/.bundle/'
  add_filter '/lib/apple_dep_client/hacks/'

  add_group 'Gem', 'lib'
end
