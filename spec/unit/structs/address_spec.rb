require 'register_sources_psc/structs/address'

RSpec.describe RegisterSourcesPsc::Address do
  let(:valid_address) do
    {
      "premises": "123 Main Street",
      "locality": "Example Town",
      region: "Exampleshire",
      "postal_code": "EX4 2MP"
    }
  end

  it 'allows address' do
    address = described_class[valid_address]

    expect(address.premises).to eq "123 Main Street"
    expect(address.locality).to eq "Example Town"
    expect(address.region).to eq "Exampleshire"
    expect(address.postal_code).to eq "EX4 2MP"
  end
end
