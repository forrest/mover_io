$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "mover_io/session"
require "mover_io/connector"
require "mover_io/collection"

module MoverIO
end

