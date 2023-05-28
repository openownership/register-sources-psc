require 'register_sources_psc/structs/individual'

RSpec.describe RegisterSourcesPsc::Individual do
  let(:valid_params) do
    {
      etag: "36c99208e0c14294355583c965e4c3f3",
      kind: "individual-person-with-significant-control",
      name_elements: {
        forename: "Joe",
        surname: "Bloggs",
      },
      nationality: "British",
      country_of_residence: "United Kingdom",
      notified_on: "2016-04-06",
      address: {
        premises: "123 Main Street",
        locality: "Example Town",
        region: "Exampleshire",
        postal_code: "EX4 2MP",
      },
      date_of_birth: {
        month: 10,
        year: 1955,
      },
      natures_of_control: %w[
        ownership-of-shares-25-to-50-percent
        voting-rights-25-to-50-percent
      ],
      links: {
        self: "/company/01234567/persons-with-significant-control/individual/abcdef123456789",
      },
    }
  end

  it 'allows valid params' do
    individual = described_class[valid_params]

    expect(individual.etag).to eq "36c99208e0c14294355583c965e4c3f3"
    expect(individual.kind).to eq "individual-person-with-significant-control"
  end
end
