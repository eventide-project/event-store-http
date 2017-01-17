require_relative '../../automated_init'

context "Read Stream Substitute, Read Predicate" do
  substitute = SubstAttr::Substitute.build EventStore::HTTP::ReadStream

  stream = Controls::Stream.example

  page = Controls::MediaTypes::Atom::Page.example

  context "Read predicate" do
    substitute.set_response stream, page

    context "Substitute has not been read" do
      test "False is returned" do
        refute substitute.read?
      end
    end

    context "Substitute has been read" do
      substitute.(stream, position: 1, batch_size: 2, direction: :forward)

      context "Block is not supplied" do
        test "True is returned" do
          assert substitute.read?
        end
      end

      context "Block is supplied" do
        test "Block is supplied stream" do
          _stream = nil

          substitute.read? do |stream|
            _stream = stream
          end

          assert _stream == stream
        end

        test "Block is supplied position" do
          position = nil

          substitute.read? do |_, _position|
            position = _position
          end

          assert position == 1
        end

        test "Block is supplied direction" do
          direction = nil

          substitute.read? do |_, _, _direction|
            direction = _direction
          end

          assert direction == :forward
        end

        test "Block is supplied batch size" do
          batch_size = nil

          substitute.read? do |_, _, _, _batch_size|
            batch_size = _batch_size
          end

          assert batch_size == 2
        end

        test "True is returned if block evaluates truthfully" do
          assert substitute.read? do
            true
          end
        end

        test "False is returned if block does not evaluate truthfully" do
          refute substitute.read? do
            false
          end
        end
      end
    end
  end
end
