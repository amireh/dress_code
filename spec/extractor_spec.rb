require_relative 'spec_helper'

describe DressCode::Extractor do
  it "extracts documentation from files" do
    @test_file = create_test_file
    @extractor = DressCode::Extractor.new({
      :files => [@test_file],
      :base_dir => 'tmp'
    })

    docs = @extractor.extract
    docs.length.should == 2
    docs[0].component.should == 'anchor'
    docs[0].prose.should == "```html\n<a>I am an anchor</a>\n```"
    docs[0].path.should == "tmp/test.css"
    docs[0].relative_path.should == "test.css"
    docs[1].component.should == 'button'
    docs[1].prose.should == "```html\n<button>I am a button</button>\n```"
    docs[1].path.should == "tmp/test.css"
    docs[1].relative_path.should == "test.css"
  end

  it "doesn't choke on utf8 content" do
    @test_file = create_utf8_test_file
    @extractor = DressCode::Extractor.new({
      :files => [@test_file],
      :base_dir => 'tmp'
    })

    @extractor.extract
  end
end

