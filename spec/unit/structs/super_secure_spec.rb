require 'register_sources_psc/structs/super_secure'

RSpec.describe RegisterSourcesPsc::SuperSecure do
  let(:valid_params) do
    {
      etag: "36c99208e0c14294355583c965e4c3a0",
      description: "super-secure-persons-with-significant-control",
      kind: "super-secure-person-with-significant-control",
      links: {
        self: "/company/1234567/persons-with-significant-control/super-secure/abcdef123456",
      },
    }
  end

  it 'allows valid params' do
    super_secure = described_class[valid_params]

    expect(super_secure.etag).to eq "36c99208e0c14294355583c965e4c3a0"
    expect(super_secure.kind).to eq "super-secure-person-with-significant-control"
  end
end
