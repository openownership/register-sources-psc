# frozen_string_literal: true

require 'register_sources_psc/structs/name_elements'

RSpec.describe RegisterSourcesPsc::NameElements do
  let(:valid_params) do
    {
      forename: 'Joe',
      surname: 'Bloggs'
    }
  end

  it 'allows valid params' do
    name_elements = described_class[valid_params]

    expect(name_elements.forename).to eq 'Joe'
    expect(name_elements.surname).to eq 'Bloggs'
  end
end
