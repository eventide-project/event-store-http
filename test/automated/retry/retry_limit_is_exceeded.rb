require_relative '../automated_init'

context "Retry Limit Is Exceeded" do
  error_cls = Class.new StandardError

  retry_limit = 11

  _retry = EventStore::HTTP::Retry.new
  _retry.retry_limit = retry_limit
  _retry.retry_duration = 0

  invocations = 0

  blk = proc { |_, retries|
    invocations += 1
    raise error_cls unless retries == retry_limit + 1
    :some_value
  }

  test "Error is raised" do
    assert proc { _retry.(&blk) } do
      raises_error? error_cls
    end
  end

  test "Block is invoked once initially plus once for every retry" do
    assert invocations == retry_limit + 1
  end
end
