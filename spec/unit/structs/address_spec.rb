require 'register_sources_psc/structs/address'

RSpec.describe RegisterSourcesPsc::Address do
  subject { described_class.new(**fields) }

  let(:fields) do
    {
      type: RegisterSourcesPsc::AddressTypes['registered'],
      address: "Some address",
      postCode: "CA1 3CD",
      country: "GB"
    }
  end

  it 'creates struct without errors' do
    expect(subject).to be_a RegisterSourcesPsc::Address
  end
end
