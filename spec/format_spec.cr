require "./spec_helper"

describe "Format" do
  it "Test with version 2" do
    definition = <<-END
   version: "2"

   services:
       a: {}
       b: { depends_on: [ "a" ] }
   END

    configuration = Decompose::Format::Configuration.from_yaml(definition)
    configuration.is_a?(Decompose::Format::Configuration).should eq true
  end
end
