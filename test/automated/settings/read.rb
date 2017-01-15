require_relative '../automated_init'

context "Read-Specific Settings" do
  context "Setting is specified in read namespace" do
    settings = Settings.build({
      :read => { :some_setting => :some_value }
    })

    settings = EventStore::HTTP::Settings::Read.get settings

    test "Setting is included" do
      assert settings.get(:some_setting) == :some_value
    end
  end

  context "Setting is specified in outer namespace" do
    settings = Settings.build({
      :some_setting => :some_value
    })

    settings = EventStore::HTTP::Settings::Read.get settings

    test "Setting is included" do
      assert settings.get(:some_setting) == :some_value
    end
  end

  context "Setting is specified in both namespaces" do
    settings = Settings.build({
      :some_setting => :other_value,
      :read => { :some_setting => :some_value }
    })

    settings = EventStore::HTTP::Settings::Read.get settings

    test "Setting is included" do
      assert settings.get(:some_setting) == :some_value
    end
  end

  context "Namespaces are nested" do
    settings = Settings.build({
      :some_namespace => {
        :some_setting => :other_value,
        :read => {
          :some_setting => :some_value
        }
      }
    })

    settings = EventStore::HTTP::Settings::Read.get(
      settings,
      namespace: :some_namespace
    )

    test "Setting in read namespace within specified namespace is preferred" do
      assert settings.get(:some_setting) == :some_value
    end
  end
end
