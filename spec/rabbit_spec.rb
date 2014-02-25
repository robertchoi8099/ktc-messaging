# encoding: UTF-8
require_relative 'spec_helper'

describe 'ktc-messaging::rabbit' do
  before { messaging_stubs }
  describe 'ubuntu' do
    before do
      @chef_run = ::ChefSpec::Runner.new ::UBUNTU_OPTS
      @chef_run.converge 'ktc-messaging::rabbit'
    end

    it 'includes rabbit recipes' do
      expect(@chef_run).to include_recipe 'rabbitmq'
      expect(@chef_run).to include_recipe 'rabbitmq::mgmt_console'
    end

    describe 'lwrps' do
      it 'does not delete the guest user' do
        expect(@chef_run).not_to(
          delete_rabbitmq_user('remove rabbit guest user')
        )
      end

      it "deletes a user not called 'guest'" do
        chef_run = ChefSpec::Runner.new(::UBUNTU_OPTS) do |node|
          node.node.set['openstack']['mq']['user'] = 'not-a-guest'
        end.converge('ktc-messaging::rabbit')

        expect(chef_run).to delete_rabbitmq_user('remove rabbit guest user')
      end

      it 'adds user' do
        resource = @chef_run.find_resource(
          'rabbitmq_user',
          'add openstack rabbit user'
        ).to_hash

        expect(resource).to include(
          user: 'guest',
          password: 'guest',
          action: [:add]
        )
      end

      it 'changes password' do
        resource = @chef_run.find_resource(
          'rabbitmq_user',
          'change openstack rabbit user password'
        ).to_hash

        expect(resource).to include(
          user: 'guest',
          password: 'guest',
          action: [:change_password]
        )
      end

      it 'adds vhost' do
        resource = @chef_run.find_resource(
          'rabbitmq_vhost',
          'add openstack rabbit vhost'
        ).to_hash

        expect(resource).to include(
          vhost: '/',
          action: [:add]
        )
      end

      it 'sets user permissions' do
        resource = @chef_run.find_resource(
          'rabbitmq_user',
          'set openstack user permissions'
        ).to_hash

        expect(resource).to include(
          user: 'guest',
          vhost: '/',
          permissions: '.* .* .*',
          action: [:set_permissions]
        )
      end

      it 'sets administrator tag' do
        resource = @chef_run.find_resource(
          'rabbitmq_user',
          'set rabbit administrator tag'
        ).to_hash

        expect(resource).to include(
          user: 'guest',
          tag: 'administrator',
          action: [:set_tags]
        )
      end
    end
  end
end
