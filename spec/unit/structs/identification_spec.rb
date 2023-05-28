require 'register_sources_psc/structs/identification'

RSpec.describe RegisterSourcesPsc::Identification do
  let(:valid_identification) do
    {
      country_registered: "United Kingdom",
      registration_number: "89101112",
    }
  end

  it 'allows identification' do
    identification = described_class[valid_identification]

    expect(identification.country_registered).to eq "United Kingdom"
    expect(identification.registration_number).to eq "89101112"
  end
end
