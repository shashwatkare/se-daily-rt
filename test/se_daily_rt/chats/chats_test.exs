defmodule SEDailyRT.ChatsTest do
  use SEDailyRT.DataCase

  alias SEDailyRT.Chats

  describe "channels" do
    alias SEDailyRT.Chats.Channels

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def channels_fixture(attrs \\ %{}) do
      {:ok, channels} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chats.create_channels()

      channels
    end

    test "list_channels/0 returns all channels" do
      channels = channels_fixture()
      assert Chats.list_channels() == [channels]
    end

    test "get_channels!/1 returns the channels with given id" do
      channels = channels_fixture()
      assert Chats.get_channels!(channels.id) == channels
    end

    test "create_channels/1 with valid data creates a channels" do
      assert {:ok, %Channels{} = channels} = Chats.create_channels(@valid_attrs)
      assert channels.name == "some name"
    end

    test "create_channels/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chats.create_channels(@invalid_attrs)
    end

    test "update_channels/2 with valid data updates the channels" do
      channels = channels_fixture()
      assert {:ok, channels} = Chats.update_channels(channels, @update_attrs)
      assert %Channels{} = channels
      assert channels.name == "some updated name"
    end

    test "update_channels/2 with invalid data returns error changeset" do
      channels = channels_fixture()
      assert {:error, %Ecto.Changeset{}} = Chats.update_channels(channels, @invalid_attrs)
      assert channels == Chats.get_channels!(channels.id)
    end

    test "delete_channels/1 deletes the channels" do
      channels = channels_fixture()
      assert {:ok, %Channels{}} = Chats.delete_channels(channels)
      assert_raise Ecto.NoResultsError, fn -> Chats.get_channels!(channels.id) end
    end

    test "change_channels/1 returns a channels changeset" do
      channels = channels_fixture()
      assert %Ecto.Changeset{} = Chats.change_channels(channels)
    end
  end

  describe "messages" do
    alias SEDailyRT.Chats.Messages
    alias SEDailyRT.Accounts
    

    @valid_attrs %{body: "some body", channel: "cool_channel"}
    @user_valid_attrs %{username: "johny_ive", email: "j@me.com", auth_id: "12355"}
    @update_attrs %{body: "some updated body"}
    @invalid_attrs %{body: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} = attrs
      |> Enum.into(@user_valid_attrs)
      |> Accounts.create_user()

      user
    end

    def messages_fixture(attrs \\ %{}) do
      user = user_fixture()
      attrs = Enum.into(attrs, @valid_attrs)
      {:ok, messages} = Chats.create_user_message(user, attrs)
      messages
    end

    test "list_messages/0 returns all messages" do
      messages = messages_fixture()
      assert Chats.list_messages() == [messages]
    end

    test "get_messages!/1 returns the messages with given id" do
      messages = messages_fixture()
      assert Chats.get_messages!(messages.id) == messages
    end

    test "create_user_message/1 with valid data creates a messages" do
      user = user_fixture()
      assert {:ok, %Messages{} = messages} = Chats.create_user_message(user, @valid_attrs)
      assert messages.body == "some body"
    end

    test "create_user_message/1 with invalid data returns error changeset" do
      user = user_fixture()      
      assert {:error, %Ecto.Changeset{}} = Chats.create_user_message(user, @invalid_attrs)
    end

    test "update_messages/2 with valid data updates the messages" do
      messages = messages_fixture()
      assert {:ok, messages} = Chats.update_messages(messages, @update_attrs)
      assert %Messages{} = messages
      assert messages.body == "some updated body"
    end

    test "update_messages/2 with invalid data returns error changeset" do
      messages = messages_fixture()
      assert {:error, %Ecto.Changeset{}} = Chats.update_messages(messages, @invalid_attrs)
      assert messages == Chats.get_messages!(messages.id)
    end

    test "delete_messages/1 deletes the messages" do
      messages = messages_fixture()
      assert {:ok, %Messages{}} = Chats.delete_messages(messages)
      assert_raise Ecto.NoResultsError, fn -> Chats.get_messages!(messages.id) end
    end

    test "change_messages/1 returns a messages changeset" do
      messages = messages_fixture()
      assert %Ecto.Changeset{} = Chats.change_messages(messages)
    end
  end
end
