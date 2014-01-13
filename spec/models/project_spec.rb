require 'spec_helper'

describe Project do
  it { should belong_to(:validator).class_name('User') }
  it { should belong_to(:creator).class_name('User') }
  it { should have_many(:targets) }
end
