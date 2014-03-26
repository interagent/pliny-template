require "test_helper"

describe Pliny::Log do
  before do
    @io = StringIO.new
    Pliny.stdout = @io
    stub(@io).puts
  end

  it "logs in structured format" do
    mock(@io).puts "foo=bar baz=42"
    Pliny.log(foo: "bar", baz: 42)
  end

  it "supports blocks to log stages and elapsed" do
    mock(@io).puts "foo=bar at=start"
    mock(@io).puts "foo=bar at=finish elapsed=0.000"
    Pliny.log(foo: "bar") do
    end
  end
end
