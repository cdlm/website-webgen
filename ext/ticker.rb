# Generate a chronologically sorted list of short news items from the metainfo of a node.
#
# Damien Pollet, Nov 2010
#
# This module provides the +ticker+ tag, for including a few selected news items in a page file.
# The news data is a simple YAML sequence in the metainfo of a regular page, under the +news+ key,
# each news item being a mapping with three keys, as follows:
#
#   news:
#     - title: Hello
#       date: 2010-10-01
#       text: First news.
#     - title: World
#       date: 2010-10-02
#       text: Second news.
#
# The idea is that either the news are specific to the page, or they are displayed somewhere else
# but the page with the +news+ metadata will act as an archive page, by using something like:
#
#   {ticker: {number: ~}}
#
module Ticker

  # A single news record
  NewsItem = Struct.new :title, :dates, :text
  class NewsItem

    def planified?
      dates.is_a? Array
    end

    def upcoming?
      on_date > Date.today + 1 # tomorrow is not really upcoming anymore
    end

    def on_date
      planified?  ?  dates[0]  :  dates
    end

    def until_date
      planified?  ?  dates[-1]  :  dates
    end

    def format_when
      if planified?
        if on_date == until_date
          "Event on #{dmy(on_date)}"
        else
          "Event from #{dmy(on_date)} to #{dmy(until_date)}"
        end
      else
        "Posted on #{dmy(on_date)}"
      end
    end

    def render_on io
      io << <<-EOS

###### #{title}
{: title='#{format_when}'}

#{text}

EOS
    end

    def dmy(date)
      date.strftime '%d %b %G'
    end
  end


  # Converting data to more convenient Ruby objects without using fancy YAML syntax
  class News

    def initialize( data, more, chronological, number, period )
      @more, @chronological, @number, @period = more, chronological, number, period
      @items = load_items data
    end

    def empty?
      @items.empty?
    end

    def more
      return nil unless @number
      @items.size > @number  ?  @more  :  nil
    end

    def all_items
      @items
    end

    def items
      @number  ?  self.all_items.first(@number)  :  self.all_items
    end

    def load_items( data )
      data = data.map { |d|  NewsItem.new d['title'], d['when'], d['text'] }
      case @period
      when :upcoming then data = data.select { |each| each.upcoming? }
      when :past     then data = data.reject { |each| each.upcoming? }
      end
      if  @chronological.nil?  &&  @period == :upcoming  ||  @chronological
      then upsort data else downsort data end
    end

    def upsort data
      data.sort { |x, y|  x.on_date <=> y.on_date }
    end

    def downsort data
      data.sort { |x, y|  y.on_date <=> x.on_date }
    end
  end


  # Selects a few items from the news in the metainfo of the given page and displays them.
  # Basic usage: +{ticker: path/to/withnews.page}+
  # If used with a body, it will be displayed before the items, and only if there are items.
  class Tag
    include Webgen::Tag::Base

    def call( tag, body, context )
      # locate the node with the news items in yaml & record dependency
      news_node = if param('ticker.path').nil?
          context.node
        else
          context.ref_node.resolve(param('ticker.path'), context.dest_node.lang)
        end
      context.dest_node.node_info[:used_nodes] << news_node.alcn
      # load & display news items
      news = News.new news_node.meta_info['news'],
                      param('ticker.more'),
                      param('ticker.chronological'),
                      param('ticker.number'),
                      param('ticker.period')
      result = ""
      unless news.empty?
        StringIO.open result do |io|
          io << body if body
          news.items.each do |item|  item.render_on io  end
          if news.more
            io.puts context.tag('link', 'path' => news_node.alcn, 'attr' => {:link_text => news.more})
          end
        end
      end
      result
    end

    # redefinition from default ticker.tag
    def tag_config_base()  'ticker'  end
  end

  # registration with webgen
  def self.init
    config = Webgen::WebsiteAccess.website.config
    config['contentprocessor.tags.map']['ticker'] = 'Ticker::Tag'
    config.ticker.path nil,
      :doc => 'Path to the node with the news data. Current node if omitted.'
    config.ticker.period :past,
      :doc => 'Which news to display. Either of :past (default), :upcoming, or :all.'
    config.ticker.number 5,
      :doc => 'Number of entries to display, or ~ (nil). Defaults to 5.'
    config.ticker.more nil,
      :doc => 'Text of the link to all news items. No link displayed if omitted.'
    config.ticker.chronological nil,
      :doc => 'Display items in chronological order (true), from newest to oldest (false), or according to period (nil, the default).'
  end
end
