require_relative '../automated_init'

context "Request Class Actuator" do
  cls = Class.new do
    include EventStore::HTTP::Request

    def call(arg=nil, kwarg: nil)
      return arg, kwarg
    end
  end

  context "Neither keyword nor positional arguments are included" do
    a, b = cls.()

    test "Method is invoked" do
      assert a == nil
      assert b == nil
    end
  end

  context "Keyword arguments are included" do
    arg, _ = cls.(:some_arg)

    test "Positional argument is passed to instance" do
      assert arg == :some_arg
    end
  end

  context "Positional arguments are included" do
    _, kwarg = cls.(kwarg: :some_kwarg)

    test "Keyword argument is passed to instance" do
      assert kwarg == :some_kwarg
    end
  end

  context "Keyword and positional arguments are included" do
    arg, kwarg = cls.(:some_arg, kwarg: :some_kwarg)

    test "Positional argument is passed to instance" do
      assert arg == :some_arg
    end

    test "Keyword argument is passed to instance" do
      assert kwarg == :some_kwarg
    end
  end
end
