module RailsObservatory
  class ControllerSubscriber < ActiveSupport::Subscriber
    attach_to :action_controller

    def process_action(event)
      { db_runtime: nil, **event.payload } => { controller:, action:, format:, status:, method:, db_runtime:, view_runtime: }
      labels = { action: "#{controller.underscore}##{action}", format:, status:, method: }
      TimeSeries.timing("#{event.name}.latency", event.duration, labels: labels)
      TimeSeries.timing("#{event.name}.db_runtime", db_runtime || 0, labels: labels)
      TimeSeries.timing("#{event.name}.view_runtime", view_runtime || 0, labels: labels)
      TimeSeries.increment("#{event.name}.count", labels: labels)
    end
  end
end