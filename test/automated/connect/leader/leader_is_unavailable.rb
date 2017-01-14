require_relative '../../automated_init'

context "Leader Connection Type" do
  context "Leader is currently unavailable" do
    context "Availability of leader is soon restored" do
      test "Connection is eventually established with leader"
    end

    context "Leader remains unavailable" do
      test "Error is raised"
    end
  end
end
