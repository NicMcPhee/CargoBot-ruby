Given /^the bot is created with script "([^"]*)"$/ do |arg1|
  @bot = Cargobot.new(arg1)
end


Given /^the claw is in position (\d+)$/ do |arg1|
  @bot.claw_position = arg1.to_i - 1
end


Given /^the subscript "([^"]*)" is loaded into Prog(\d+)$/ do |arg1, arg2|
  arg1.scan(/w+/) do |word|
    @bot.script[arg2.to_i - 1] = word.intern
  end
end


Given /^the bot has (\d+) stacks$/ do |arg1|
  @bot.stacks = arg1.to_i.times.collect {Array.new}
end


Given /^the bot is created with script "([^"]*)" and (\d+) stacks$/ do |arg1, arg2|
  @bot = Cargobot.new(arg1,stacks:arg2.to_i.times.collect {[]})
end


Given /^the top box on stack (\d+) is (\w+)$/ do |arg1, arg2|
  @bot.stacks[arg1.to_i-1].push arg2.intern
end


Given /^the step limit is (\d+)$/ do |arg1|
  @bot.step_limit = arg1.to_i
end



When /^I activate the cargobot$/ do
  @bot.activate
end


Then /^the bot's program should have (\d+) subroutines?$/ do |arg1|
  @bot.program.length.should == arg1.to_i
end


Then /^the number of moves should be (\d+)$/ do |arg1|
  @bot.moves.should == arg1.to_i
end


Then /^the number of steps should be (\d+)$/ do |arg1|
  @bot.steps.should == arg1.to_i
end



Then /^subroutine (\d+) should have (\d+) tokens?$/ do |arg1, arg2|
  @bot.program[arg1.to_i-1].length.should == arg2.to_i
end


Then /^subroutine (\d+) should have tokens (\[.+\])$/ do |arg1, arg2|
  @bot.program[arg1.to_i - 1].inspect.should == arg2
end


Then /^stack (\d+) should be (\[.+\])$/ do |arg1, arg2|
  @bot.stacks[arg1.to_i - 1].inspect.should == arg2
end


Then /^the claw should be in position (\d+)$/ do |arg1|
  @bot.claw_position.should == arg1.to_i - 1
end


Then /^the number of crashes should be (\d+)$/ do |arg1|
  @bot.crashes.should == arg1.to_i
end


Then /^the claw should contain a (\w+) box$/ do |arg1|
  @bot.claw_holding.should == arg1.intern
end


Then /^the number of boxes in stack (\d+) should be (\d+)$/ do |arg1, arg2|
  @bot.stacks[arg1.to_i-1].length.should == arg2.to_i
end


Then /^the claw should be empty$/ do
  @bot.claw_holding.should be_nil
end


Then /^stack (\d+) should be empty$/ do |arg1|
  @bot.stacks[arg1.to_i-1].should be_empty
end

Then /^the stack trace should contain (\d+) items$/ do |arg1|
  @bot.stack_trace.length.should == arg1.to_i
end
