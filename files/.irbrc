# hi glen
# Process.kill :SEGV, $$ if rand < 0.5

require "irb/completion"

unless 'macruby' == RUBY_ENGINE
  require 'irb/ext/save-history'
  ARGV.concat [ "--readline", "--prompt-mode", "simple" ]
end

IRB.conf[:SAVE_HISTORY] = 10000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history" 
IRB.conf[:PROMPT_MODE] = :DEFAULT
