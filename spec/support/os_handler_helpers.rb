module Helpers
  def windows
    !!((RUBY_PLATFORM =~ /(win|w)(32|64)$/) || (RUBY_PLATFORM=~ /mswin|mingw/))
  end
end
