require "spec_helper"

describe Comprehension do
  it "has a version number" do
    expect(Comprehension::VERSION).not_to be nil
  end

  specify do
    expect(->(i, j){ i * j }.comprehension(1..9, 1..9)).to eq([*1..9].product([*1..9]).map {|i, j| i * j })
  end

  specify do
    expect(->(i, j){ i * j }.comprehension(1..9, 1..9)).to be_an(Array)
  end

  specify do
    expect(->(i, j){ i * j }.lazy_comprehension(1..9, 1..9)).to be_an(Enumerator)
  end

  specify do
    expect { |b|
      ->(i){ 2*i }.comprehension(1..3, &b)
    }.to yield_successive_args(2, 4, 6)
    expect { |b|
      ->(i, j){ [i, 10+j] }.comprehension(1..3, 1..3, &b)
    }.to yield_successive_args([1, 11], [1, 12], [1, 13], [2, 11], [2, 12], [2, 13], [3, 11], [3, 12], [3, 13])
  end
end
