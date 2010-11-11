Amp::Command.create('root') do |c|
  c.has_repo
  c.validates_argument_count(:minimum => 1)
  c.on_call do
    arguments.each do |arg|
      p repository[arg]
    end
  end
end