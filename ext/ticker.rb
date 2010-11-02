module Ticker

  NewsItem = Struct.new :title, :date, :contents
  class NewsItem
    def id
      "#{title.gsub(/[^\w_-]/, '-')}-#{date}"
    end

    def format_date
      date.strftime '%d %b %G'
    end
  end


  class News
    
    def initialize( io, number=5, more=true )
      @number, @more = number, more
      @items = read_items io
    end
    
    def all_items
      @items
    end
    
    def items
      self.all_items.first @number
    end
    
    def read_items(io)
      yaml = begin
          YAML.load(io) || []
        rescue ArgumentError, SystemCallError
          []
        end
      yaml.map { |d|
          NewsItem.new d['title'], d['date'], d['contents']
        }.sort { |x, y|  y.date <=> x.date }
    end
  end
  
  
  class Tag
    include Webgen::Tag::Base
    include
    def call( tag, body, context )
      news_node = context.node.resolve(param('ticker.path'))
      # (context.dest_node.node_info[:tag_ticker_filenames] ||= []) << [node.path, File.mtime(node.path)] #incorrect, should be used_nodes
      context.dest_node.node_info[:used_nodes] << news_node

      news_src_path = website.blackboard.invoke(:source_paths)[news_node.node_info[:src]]
      news = news_src_path.io.stream { |io|
        News.new io, param('ticker.number'), param('ticker.more')
      }
      news.all_items.size
    end
    
    # def node_changed?(node)
    #   if filenames = node.node_info[:tag_ticker_filenames]
    #     node.flag(:dirty) if filenames.any? { |f, mtime| File.mtime(f) > mtime }
    #   end
    # end
    
    # redefine this because by default it would be ticker.tag
    def tag_config_base()  'ticker'  end
  end
    
end


config = Webgen::WebsiteAccess.website.config
config['contentprocessor.tags.map']['ticker'] = 'Ticker::Tag'
config.ticker.path nil,
  :doc => 'Path to the YAML data node. Mandatory.',
  :mandatory => 'default'
config.ticker.number 5,
  :doc => 'Number of entries to display. Defaults to 5.'
config.ticker.more true,
  :doc => 'Set to false to disable the "Read more..." link.'
