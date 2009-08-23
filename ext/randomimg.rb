class Hash
  def to_js
    "{" + self.collect { |k,v| "#{k.to_js}:#{v.to_js}"}.join(", ") + "}"
  end
end
class String
  def to_js;  "'#{self.js_escape}'"; end
  def js_escape;  self.gsub(/'/, '\\\\\''); end
end
class NilClass
  def to_js; 'undefined'; end
end
class Object
  def to_js; self.to_s.to_js; end
end


class RandomImg
  include Webgen::Tag::Base
  include Webgen::WebsiteAccess
  
  website.config['contentprocessor.tags.map']['randomimg'] = 'RandomImg'
  website.config.randomimg.dir nil,
    :doc => 'Directory to pick images from. Mandatory.',
    :mandatory => 'default'
  website.config.randomimg.attrs Hash.new,
    :doc => 'Attributes for the image. Override metainfo.'
  website.config.randomimg.default_attrs Hash.new,
    :doc => 'Attributes for the image. Overriden by metainfo.'

  def call( tag, body, context )
    ensure_js_head( context )
    dirnode = context.node.resolve(param('randomimg.dir'))
    attrs, default_attrs = param('randomimg.attrs'), param('randomimg.default_attrs')
    pickable = dirnode.children.reject { |n| n.cn == 'metainfo' }.collect { |n|
      h = { :src => context.tag('relocatable', 'path' => n.alcn) }
      (attrs.keys + default_attrs.keys + ['alt', 'title']).uniq.each do |k|
        value = n.meta_info[k] || default_attrs[k]
        h[k] = value unless attrs.has_key?(k) or value.nil?
      end
      h
    }
    arguments = [attrs, *pickable].collect {|arg| arg.to_js }
    return "<img src=\"#{pickable[0][:src]}\" onload=\"randomimg(this,#{arguments.join(",")})\"/>"
  end
  
  def ensure_js_head( context )
    cp_head = context.persistent[:cp_head] ||= {}
    scripts = cp_head[:js_inline] ||= []
    scripts << "
      function randomimg(img, attrs, list) {
        for (var i in attrs) {
          img[i] = attrs[i];
        }
        chosen = arguments[Math.floor(Math.random()*(arguments.length-2))+2];
        for (var i in chosen) {
          img[i] = chosen[i];
        }
      }"
  end
  
end

# link or img