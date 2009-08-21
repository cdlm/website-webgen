class Mailto
  include Webgen::Tag::Base
  include Webgen::WebsiteAccess
  
  website.config['contentprocessor.tags.map']['mailto'] = 'Mailto'
  website.config.mailto.email nil,
    :doc => 'The destination email address. Mandatory.',
    :mandatory => 'default'
  website.config.mailto.link nil,
    :doc => 'The linked text. Defaults to the email address.'
  website.config.mailto.subject nil,
    :doc => 'The subject of the mail message. Optional.'

  def call( tag, body, context )
    email = encode_email(param('mailto.email'))
    link = param('mailto.link') || email
    subject = param('mailto.subject')
    html = "<a href='mailto:#{email}#{'?subject=' + subject unless subject.nil?}'>#{link}</a>"
    return [html,false]
  end

  def encode_email( mail )
    expanded = mail #mail.gsub('.', ' dot ').gsub('@', ' at ')
    entities = ""
    expanded.each_char { |c| entities << "&##{c[0].ord};"}
    return entities
  end

end
