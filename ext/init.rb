# = webgen extensions directory
#
# All init.rb files anywhere under this directory get automatically loaded on a webgen run. This
# allows you to add your own extensions to webgen or to modify webgen's core!
#
# If you don't need this feature you can savely delete this file and the directory in which it is!

require 'ext/lipsum.rb'
require 'ext/mailto.rb'; Mailto.init
require 'ext/randomimg.rb'; RandomImg.init
require 'ext/blog.rb'; Blog.init
require 'ext/ticker.rb'; Ticker.init
