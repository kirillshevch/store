require 'rails_helper'

RSpec.describe CountryHelper, type: :helper do
  let!(:country_list) { FactoryGirl.create_list(:country, 3) }

  describe '#countries' do
    it 'returns all countries' do
      expect(helper.countries).to eq(country_list)
    end
  end
end