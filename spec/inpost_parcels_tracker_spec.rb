require "spec_helper"

describe InpostParcelsTracker do
  it "has a version number" do
    expect(InpostParcelsTracker::VERSION).not_to be '1.0.0'
  end
end

describe 'Inpost::Parcel' do
  let(:mock_success) do
    file = File.join('spec', 'responses', 'success.json')
    JSON.parse(File.read(file)).with_indifferent_access
  end

  let(:mock_fail) do
    file = File.join('spec', 'responses', 'fail.json')
    JSON.parse(File.read(file)).with_indifferent_access
  end

  let(:success) { Inpost::Parcel.new('111111111111111111111111') }
  let(:failure) { Inpost::Parcel.new('222222222222222222222222') }
  let(:error) { Inpost::Parcel.new('123') }

  context 'initialize' do
    it 'tracking code' do
      expect(success.instance_variables.blank?).to eq false
      expect(success.instance_values.values).to eq(%w(111111111111111111111111))
      expect { error }.to raise_error(RuntimeError)
    end
  end

  context 'track' do
    it 'returns json response - success' do
      allow(success).to receive_message_chain('track').and_return(mock_success)
      response = success.track
      expect(response.fetch('tracking_number')).to eq('111111111111111111111111')
      expect(response.fetch('status')).to eq('ready_to_pickup')
    end
    it 'returns json response - fail' do
      allow(failure).to receive_message_chain('track').and_return(mock_fail)
      response = failure.track
      expect(response.fetch('status')).to eq(404)
      expect(response.fetch('error')).to eq('resource_not_found')
    end
  end
end
