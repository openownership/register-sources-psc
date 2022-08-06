require 'register_sources_psc/structs/statement'

RSpec.describe RegisterSourcesPsc::Statement do
  let(:valid_params) do
    {
      "etag": "36c99208e0c14294355583c965e4c3f9",
      "kind": "persons-with-significant-control-statement",
      statement: "no-individual-or-entity-with-signficant-control",
      "notified_on": "2016-07-12",
      "links": {
        "self": "/company/1234567/exemptions"
      }
    }
  end

  it 'allows valid params' do
    statement = described_class[valid_params]

    expect(statement.etag).to eq "36c99208e0c14294355583c965e4c3f9"
    expect(statement.statement).to eq "no-individual-or-entity-with-signficant-control"
  end
end
