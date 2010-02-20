class Mailto
  include Webgen::Tag::Base
    
  def call( tag, body, context )
    email = encode_email(param('mailto.to'))
    link = param('mailto.link') || email
    subject = param('mailto.subject')
    html = "<a href='mailto:#{email}#{'?subject=' + subject unless subject.nil?}'>#{link}</a>"
    return [html,false]
  end

# private

  def encode_email( mail )
    expanded = mail #mail.gsub('.', ' dot ').gsub('@', ' at ')
    entities = ""
    expanded.each_char { |c| entities << "&##{c[0].ord};"}
    return entities
  end

end

config = Webgen::WebsiteAccess.website.config
config['contentprocessor.tags.map']['mailto'] = 'Mailto'
config.mailto.to nil,
  :doc => 'The destination email address. Mandatory.',
  :mandatory => 'default'
config.mailto.link nil,
  :doc => 'The linked text. Defaults to the email address.'
config.mailto.subject nil,
  :doc => 'The subject of the mail message. Optional.'
