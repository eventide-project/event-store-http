require_relative '../automated_init'

context "Retry When First Attempt Is Successful" do
  _retry = EventStore::HTTP::Retry.new

  invocations = 0

  return_value = _retry.() do
    invocations += 1
    :some_value
  end

  test "Return value is that of block" do
    assert return_value == :some_value
  end

  test "Block is invoked only once" do
    assert invocations == 1
  end
end
