# thanks to https://gist.github.com/maxlinc/3548319e652c83031e49
require 'rouge'
module Rouge
  module Lexers
    class JSONParameter < Rouge::Lexers::JSON
      tag 'json_parameter'
    end
    class JSONResponse < Rouge::Lexers::JSON
      tag 'json_response'
    end
  end
end
