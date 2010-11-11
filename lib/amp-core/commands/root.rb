Amp::Command.create('root') do |c|
  c.has_repo
  c.on_call do
    p repository.root
  end
end