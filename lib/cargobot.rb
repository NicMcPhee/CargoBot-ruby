class CargoBot
  attr_accessor :fragile, :unstable, :program, :stacks, :claw_position, :step_limit, :goal
  attr_reader :claw_holding, :crashes, :topples, :steps
  
  def initialize
    @program = Array.new
    @stacks = Array.new
    @commands = Array.new
    @crashes = 0
    @topples = 0
    @steps = 0
    @step_limit = 200
  end
  
  def activate
    call(1)
    while not_finished
      @steps += 1
      process_command(@commands.pop)
    end
  end
  
  def not_finished
    !@commands.empty? and
      @crashes == 0 and 
      @topples == 0 and 
      (@step_limit.nil? or @steps < @step_limit) and
      goal_not_reached
  end
  
  def goal_not_reached
    @stacks != @goal
  end
  
  def process_command(c)
    case c
    when /call(\d)(_)?(\w+)?/
      call($1.to_i) if satisfies_condition($3)
    when /L(_)?(\w+)?/
      move(-1) if satisfies_condition($2)
    when /R(_)?(\w+)?/
      move(+1) if satisfies_condition($2)
    when /claw(_)?(\w+)?/
      claw if satisfies_condition($2)
    else
      raise "Unknown command: " + c.to_s
    end
  end
  
  def satisfies_condition(condition)
    condition.nil? or 
      (condition == "any" and !@claw_holding.nil?) or
      (condition == "none" and @claw_holding.nil?) or
      @claw_holding.to_s == condition
  end
  
  def call(prog)
    @program[prog-1].reverse_each { |c| @commands.push(c) }
  end
  
  def move(delta)
    @claw_position += delta
    if @claw_position < 1
      @claw_position = 1
      @crashes += 1
    end
    if @claw_position > @stacks.size
      @claw_position = @stacks.size
      @crashes += 1
    end
    if @stacks[@claw_position-1].size > 6
      @topples += 1
    end
  end
  
  def claw
    if @claw_holding
      @stacks[@claw_position-1].push(@claw_holding)
      @claw_holding = nil
    else
      @claw_holding = @stacks[@claw_position-1].pop
    end
  end
end