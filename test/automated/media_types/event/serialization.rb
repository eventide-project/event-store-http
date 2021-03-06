require_relative '../../automated_init'

context "Event Media Type Serialization" do
  context "Single event" do
    data = Controls::MediaTypes::Events.example

    context "Raw data" do
      raw_data = Transform::Write.raw_data data

      test do
        assert raw_data == [{
          :event_id => Controls::Event::ID.example,
          :event_type => Controls::Event::Type.example,
          :data => Controls::Event::Data.example
        }]
      end
    end

    context "JSON text" do
      control_text = Controls::MediaTypes::Events::JSON.text
      control_text = JSON.generate JSON.parse(control_text)

      text = Transform::Write.(data, :json)

      assert text == control_text
    end
  end

  context "Single event with metadata" do
    data = Controls::MediaTypes::Events.example metadata: true

    context "Raw data" do
      raw_data = Transform::Write.raw_data data

      test "Metadata is included" do
        assert raw_data == [{
          :event_id => Controls::Event::ID.example,
          :event_type => Controls::Event::Type.example,
          :data => Controls::Event::Data.example,
          :metadata => Controls::Event::Metadata.example
        }]
      end
    end
  end

  context "Multiple events" do
    data = Controls::MediaTypes::Events.example batch_size: 3

    context "Raw data" do
      raw_data = Transform::Write.raw_data data

      test "Each event in batch is included" do
        assert raw_data.count == 3
      end
    end
  end
end
