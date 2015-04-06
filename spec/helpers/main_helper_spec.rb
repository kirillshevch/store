require 'rails_helper'

RSpec.describe MainHelper, type: :helper do
  describe '#active' do
    it 'returns active string' do
      expect(helper.active(0)).to eq('active')
    end

    it 'returns nil' do
      expect(helper.active(1)).to eq(nil)
    end
  end
end