require 'active_support/all'
require_relative "../../lib/split_datetime/accessors.rb"

describe SplitDatetime::Accessors do
  let(:model) { Model.new }
  before do
    class ModelParent; attr_accessor :starts_at; end
    class Model < ModelParent; attr_accessor :starts_at; end
    Model.extend(SplitDatetime::Accessors)
    Model.should_receive(:attr_accessible).with("starts_at_date", "starts_at_hour", "starts_at_min")
    Model.accepts_split_datetime_for(:starts_at)
  end

  describe "#starts_at" do
    it "lets the superclass (usually ActiveRecord::Base) override the value" do
      class ModelParent; def starts_at; 5; end; end
      model.starts_at.should == 5
    end

    it "sets the default time to Time.now" do
      now = Time.new(2222, 12, 22, 13, 44)
      Time.stub(:now) { now }
      model.starts_at.should == now.change(min: 0)
    end

    it "allows setting the default value through options" do
      Model.stub(:attr_accessible)
      Model.accepts_split_datetime_for(:starts_at, default: lambda { 10 })
      Model.new.starts_at.should == 10
    end
  end

  describe "split datetime methods" do
    before { model.starts_at = Time.new(2222, 12, 22, 13, 44, 0) }
    describe "#starts_at_date" do
      it "returns the model's starts_at date as string" do
        model.starts_at_date.should == "2222-12-22"
      end

      it "lets you modify the format" do
        Model.stub(:attr_accessible)
        Model.accepts_split_datetime_for(:starts_at, format: "%D")
        model.starts_at_date.should == "12/22/22"
      end

      it "sets the appropiate parts of #starts_at" do
        model.starts_at_date = Time.new(1111, 1, 1)
        model.starts_at.should == Time.new(1111, 1, 1, 13, 44, 0)
      end

      it "can set from a string" do
        model.starts_at_date = "1111-01-01"
        model.starts_at.should == Time.new(1111, 1, 1, 13, 44, 0)
      end
    end

    describe "#starts_at_hour" do
      it "returns the hour" do
        model.starts_at_hour.should == 13
      end

      it "sets the hour of starts_at" do
        model.starts_at_hour = 11
        model.starts_at.should == Time.new(2222, 12, 22, 11, 44, 0)
      end
    end

    describe "#starts_at_min" do
      it "returns the min" do
        model.starts_at_min.should == 44
      end

      it "sets the minute of #starts_at" do
        model.starts_at_min = 55
        model.starts_at.should == Time.new(2222, 12, 22, 13, 55, 0)
      end
    end
  end
end
