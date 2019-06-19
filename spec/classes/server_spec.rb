require 'spec_helper'
describe 'stns_v2::server' do
  context 'with defaults for all parameters' do
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('stns_v2::server') }
  end
end
