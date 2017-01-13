require_relative '../automated_init'

context "Settings Specifies Type" do
  settings = Settings.build({ :type => 'raw' })

  connect = EventStore::HTTP::Connect.build settings

  test "Implementation corresponding to specified type is selected" do
    assert connect.instance_of?(EventStore::HTTP::Connect::Raw)
  end
end
