require "spec_helper"

describe Comprehension do
  it "has a version number" do
    expect(Comprehension::VERSION).not_to be nil
  end

  specify do
    expect(->(i, j){ i * j }.comprehension(1..9, 1..9).to_a).to eq([*1..9].product([*1..9]).map {|i, j| i * j })
  end
end
