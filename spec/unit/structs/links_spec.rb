require 'register_sources_psc/structs/links'

RSpec.describe RegisterSourcesPsc::Links do
  let(:valid_params) do
    {
      "self": "/company/01234567/persons-with-significant-control/individual/abcdef123456789"
    }
  end

  it 'allows valid params' do
    links = described_class[valid_params]

    expect(links.self).to eq "/company/01234567/persons-with-significant-control/individual/abcdef123456789"
  end
end
