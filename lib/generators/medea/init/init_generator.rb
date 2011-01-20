require 'generators/medea'
require 'rails/generators/generated_attribute'
require 'medea'

module Medea
  module Generators
    class InitGenerator < Base
      no_tasks {
        attr_accessor :topic, :user, :pass

        def random_string length = 25
          rand(32**length).to_s(32)
        end
      }
      argument :jason_topic, :type => :string, :required => false, :banner => "Topic"
      argument :username, :type => :string, :required => false, :banner => "username"
      argument :password, :type => :string, :required => false, :banner => "password"

      def initialize(*args, &block)
        super

        @topic = jason_topic
        @topic ||= random_string 10
        @user = username
        @user ||= random_string
        @pass = password
        @pass ||= random_string
      end

      def init_jasondb
        #we can't create the topic, but we can create database.yml
        template "database.yml", "config/database.yml"
        template "jasondb.rb", "config/initializers/jasondb.rb"

      end
    end
  end
end
