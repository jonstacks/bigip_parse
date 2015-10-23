require 'spec_helper'

describe BigIParse::Config::Section do
  let(:example_config) do
    <<-CONFIG.strip_heredoc
      ltm node node_name {
        address 192.168.1.1
        sub-config { a b c }
      }
    CONFIG
  end

  describe '#content' do
    it 'returns nil if content is nil' do
      expect(BigIParse::Config::Section.new(nil, nil).content).to be nil
    end

    it 'returns nil if content is an empty string' do
      expect(BigIParse::Config::Section.new(nil, "\n   \n").content).to be nil
    end

    it 'returns the supplied content formatted' do
      section = BigIParse::Config::Section.new(nil, "\n A Test Config\n Hello")
      expect(section.content).to eql("A Test Config\nHello")
    end
  end

  describe '#header' do
    it 'returns the header' do
      header = 'ltm node /F5/NodeName'
      expect(BigIParse::Config::Section.new(header, nil).header).to eql(header)
    end
  end

  describe '#subsections' do
    it 'Correctly parses subsections do' do
      section = BigIParse::Config::Section.new(nil, example_config)
      subsection = section.subsections.first
      expect(subsection.header).to eql('ltm node node_name')
      expect(subsection.content).to eql(
        <<-CONFIG.strip_heredoc
          address 192.168.1.1
          sub-config { a b c }
        CONFIG
      )
    end

    it 'parses configs without content' do
      content = <<-CONFIG.strip_heredoc
        address 192.168.1.1
        sub-config { a b c }
      CONFIG
      section = BigIParse::Config::Section.new(nil, content)

      expect(section.subsections.first.header).to eql('address 192.168.1.1')
      expect(section.subsections.first.content).to be nil
      expect(section.subsections.last.header).to eql('sub-config')
      expect(section.subsections.last.content).to eql('a b c')
    end
  end
end
