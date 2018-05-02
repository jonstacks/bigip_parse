# frozen_string_literal: true

require 'active_support/core_ext/string'

module BigIParse
  # Class for working with BIG IP Configs
  class Config
    # Class to represent a section of a config file
    class Section
      attr_reader :header

      REGEX = /
        ^(?<header>([^\s{}#]+[ ]?)+) # Header definition
        ({                         # Opening bracket
          (?<content>(             # Optional content capture everything
              [^\n]*(?=\s})        # not a new-line followed by space bracket
              |                    # OR
              .*?(?=^})            # everything then closing bracket
            )
          )
        )?                         # Make content capture optional
      /mx

      def initialize(header, content = nil)
        @header = header
        @content = content
      end

      def content
        return nil if @content.nil?
        return nil if @content.strip.empty?
        @content.strip_heredoc.lstrip
      end

      def subsections?
        !content.nil?
      end

      def subsections
        return [] if content.nil?
        content.scan(REGEX).map { |h, c| self.class.new(h.strip, c) }
      end

      def to_s
        "#{self.class.name}(header=#{header}, content=#{content})"
      end
    end

    def initialize(str)
      @config = Section.new(nil, str)
    end

    def subsections
      @config.subsections
    end
  end
end
