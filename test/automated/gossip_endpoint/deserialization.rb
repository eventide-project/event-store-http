require_relative '../automated_init'

context "Gossip Endpoint Response Deserialization" do
  json_text = Controls::Endpoints::Gossip::Response::JSON.text

  response = Transform::Read.(
    json_text,
    :json,
    EventStore::HTTP::Endpoints::Gossip::Response
  )

  test "Server IP address" do
    assert response.server_ip == Controls::Endpoints::Gossip::Response.server_ip
  end

  test "Server port" do
    assert response.server_port == Controls::Endpoints::Gossip::Response.server_port
  end

  context "Leader member" do
    leader = response.leader

    test "Is member" do
      assert leader.instance_of?(EventStore::HTTP::Endpoints::Gossip::Response::Member)
    end

    test "Instance ID" do
      assert leader.instance_id == Controls::Endpoints::Gossip::Response::Member::Leader.instance_id
    end

    test "Timestamp" do
      assert leader.time_stamp == Controls::Endpoints::Gossip::Response::Member::Leader.time_stamp
    end

    test "State" do
      assert leader.state == Controls::Endpoints::Gossip::Response::Member::Leader.state
    end

    test "Alive status" do
      assert leader.is_alive == Controls::Endpoints::Gossip::Response::Member::Leader.is_alive
    end

    test "Internal TCP IP adress" do
      assert leader.internal_tcp_ip == Controls::Endpoints::Gossip::Response::Member::Leader.internal_tcp_ip
    end

    test "Internal TCP port" do
      assert leader.internal_tcp_port == Controls::Endpoints::Gossip::Response::Member::Leader.internal_tcp_port
    end

    test "Internal secure TCP port" do
      assert leader.internal_secure_tcp_port == Controls::Endpoints::Gossip::Response::Member::Leader.internal_secure_tcp_port
    end

    test "External TCP IP adress" do
      assert leader.external_tcp_ip == Controls::Endpoints::Gossip::Response::Member::Leader.external_tcp_ip
    end

    test "External TCP port" do
      assert leader.internal_tcp_port == Controls::Endpoints::Gossip::Response::Member::Leader.internal_tcp_port
    end

    test "External secure TCP port" do
      assert leader.external_secure_tcp_port == Controls::Endpoints::Gossip::Response::Member::Leader.external_secure_tcp_port
    end

    test "Internal HTTP IP adress" do
      assert leader.internal_http_ip == Controls::Endpoints::Gossip::Response::Member::Leader.internal_http_ip
    end

    test "Internal HTTP port" do
      assert leader.internal_http_port == Controls::Endpoints::Gossip::Response::Member::Leader.internal_http_port
    end

    test "External HTTP IP adress" do
      assert leader.external_http_ip == Controls::Endpoints::Gossip::Response::Member::Leader.external_http_ip
    end

    test "External HTTP port" do
      assert leader.internal_http_port == Controls::Endpoints::Gossip::Response::Member::Leader.internal_http_port
    end

    test "Last commit position" do
      assert leader.last_commit_position == Controls::Endpoints::Gossip::Response::Member::Leader.last_commit_position
    end

    test "Writer checkpoint" do
      assert leader.writer_checkpoint == Controls::Endpoints::Gossip::Response::Member::Leader.writer_checkpoint
    end

    test "Chaser checkpoint" do
      assert leader.chaser_checkpoint == Controls::Endpoints::Gossip::Response::Member::Leader.chaser_checkpoint
    end

    test "Epoch position" do
      assert leader.epoch_position == Controls::Endpoints::Gossip::Response::Member::Leader.epoch_position
    end

    test "Epoch number" do
      assert leader.epoch_number == Controls::Endpoints::Gossip::Response::Member::Leader.epoch_number
    end

    test "Epoch ID" do
      assert leader.epoch_id == Controls::Endpoints::Gossip::Response::Member::Leader.epoch_id
    end

    test "Node priority" do
      assert leader.node_priority == Controls::Endpoints::Gossip::Response::Member::Leader.node_priority
    end
  end

  (1..2).each do |index|
    context "Follower member ##{index}" do
      follower = response.followers[index - 1]
      follower_index = Controls::Endpoints::Gossip::Response::Member::Index.follower index

      test "Is member" do
        assert follower.instance_of?(EventStore::HTTP::Endpoints::Gossip::Response::Member)
      end

      test "Instance ID" do
        assert follower.instance_id == Controls::Endpoints::Gossip::Response::Member.instance_id(follower_index)
      end

      test "Timestamp" do
        assert follower.time_stamp == Controls::Endpoints::Gossip::Response::Member.time_stamp
      end

      test "State" do
        assert follower.state == Controls::Endpoints::Gossip::Response::Member.state(follower_index)
      end

      test "Alive status" do
        assert follower.is_alive == Controls::Endpoints::Gossip::Response::Member.is_alive(follower_index)
      end

      test "Internal TCP IP adress" do
        assert follower.internal_tcp_ip == Controls::Endpoints::Gossip::Response::Member.internal_tcp_ip(follower_index)
      end

      test "Internal TCP port" do
        assert follower.internal_tcp_port == Controls::Endpoints::Gossip::Response::Member.internal_tcp_port
      end

      test "Internal secure TCP port" do
        assert follower.internal_secure_tcp_port == Controls::Endpoints::Gossip::Response::Member.internal_secure_tcp_port
      end

      test "External TCP IP adress" do
        assert follower.external_tcp_ip == Controls::Endpoints::Gossip::Response::Member.external_tcp_ip(follower_index)
      end

      test "External TCP port" do
        assert follower.internal_tcp_port == Controls::Endpoints::Gossip::Response::Member.internal_tcp_port
      end

      test "External secure TCP port" do
        assert follower.external_secure_tcp_port == Controls::Endpoints::Gossip::Response::Member.external_secure_tcp_port
      end

      test "Internal HTTP IP adress" do
        assert follower.internal_http_ip == Controls::Endpoints::Gossip::Response::Member.internal_http_ip(follower_index)
      end

      test "Internal HTTP port" do
        assert follower.internal_http_port == Controls::Endpoints::Gossip::Response::Member.internal_http_port
      end

      test "External HTTP IP adress" do
        assert follower.external_http_ip == Controls::Endpoints::Gossip::Response::Member.external_http_ip(follower_index)
      end

      test "External HTTP port" do
        assert follower.internal_http_port == Controls::Endpoints::Gossip::Response::Member.internal_http_port
      end

      test "Last commit position" do
        assert follower.last_commit_position == Controls::Endpoints::Gossip::Response::Member.last_commit_position
      end

      test "Writer checkpoint" do
        assert follower.writer_checkpoint == Controls::Endpoints::Gossip::Response::Member.writer_checkpoint
      end

      test "Chaser checkpoint" do
        assert follower.chaser_checkpoint == Controls::Endpoints::Gossip::Response::Member.chaser_checkpoint
      end

      test "Epoch position" do
        assert follower.epoch_position == Controls::Endpoints::Gossip::Response::Member.epoch_position
      end

      test "Epoch number" do
        assert follower.epoch_number == Controls::Endpoints::Gossip::Response::Member.epoch_number
      end

      test "Epoch ID" do
        assert follower.epoch_id == Controls::Endpoints::Gossip::Response::Member.epoch_id
      end

      test "Node priority" do
        assert follower.node_priority == Controls::Endpoints::Gossip::Response::Member.node_priority
      end
    end
  end
end
