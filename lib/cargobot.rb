class CargoBot
  attr_accessor :fragile, :unstable, :program, :stacks, :claw_position, :step_limit
  attr_reader :claw_holding, :crashes, :topples, :steps
  
  def initialize
    @program = Array.new
    @stacks = Array.new
    @commands = Array.new
    @crashes = 0
    @topples = 0
    @steps = 0
  end
  
  def activate
    call(1)
    while not_finished
      @steps += 1
      process_command(@commands.pop)
    end
  end
  
  def call(prog)
    @program[prog-1].reverse_each { |c| @commands.push(c) }
  end
  
  def not_finished
    !@commands.empty? and
      @crashes == 0 and 
      @topples == 0 and 
      (@step_limit.nil? or @steps < @step_limit)
  end
  
  def process_command(c)
    case c
    when /call(\d)$/
      call($1.to_i)
    when /L/
      move(-1)
    when /R/
      move(1)
    when /claw_(\w+)/
      if @claw_holding.to_s == $1
        claw
      end
    when /claw/
      claw
    else
      raise "Unknown command: " + c.to_s
    end
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