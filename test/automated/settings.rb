require_relative './automated_init'

context "Settings" do
  context "Setting names" do
    settings = EventStore::HTTP::Settings.build({
      :host => 'some-host',
      :port => 11111,
      :type => 'leader',
      :keep_alive_timeout => 1,
      :open_timeout => 2,
      :read_timeout => 3,
      :read_host => 'other-host'
    })

    EventStore::HTTP::Settings.names.each do |name|
      test "#{name}" do
        assert settings.get(name)
      end
    end
  end

  context "Default settings" do
    settings = EventStore::HTTP::Settings.build

    assert settings.data == Settings.build('settings/event_store_http.json').data
  end
end
