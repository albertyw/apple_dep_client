SimpleCov.start do
  add_filter '/spec/'
  add_filter '/.bundle/'

  add_group 'Gem', 'lib'
end
