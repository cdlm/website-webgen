# = webgen extensions directory
#
# All init.rb files anywhere under this directory get automatically loaded on a webgen run. This
# allows you to add your own extensions to webgen or to modify webgen's core!
#
# If you don't need this feature you can savely delete this file and the directory in which it is!

load 'ext/lipsum.rb'
load 'ext/mailto.rb'
load 'ext/randomimg.rb'
load 'ext/blog.rb'
Blog.setup
load 'ext/ticker.rb'
