require_relative '../automated_init'

context "Retry Limit Is Reached" do
  retry_limit = 11

  _retry = EventStore::HTTP::Retry.new
  _retry.retry_limit = retry_limit
  _retry.retry_duration = 0

  invocations = 0

  blk = proc { |_, retries|
    invocations += 1
    fail unless retries == retry_limit
    :some_value
  }

  return_value = _retry.(&blk)

  test "Return value is that of final execution of block" do
    assert return_value == :some_value
  end

  test "Block is invoked once initially plus once for every retry" do
    assert invocations == retry_limit + 1
  end
end
