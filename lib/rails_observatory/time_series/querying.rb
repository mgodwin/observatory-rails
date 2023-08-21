module RailsObservatory
  module TimeSeries::Querying
      def where(**conditions)

        keys = $redis.call("TS.QUERYINDEX", *conditions.map do |k, v|
          if v == "*"
            "#{k}!="
          else
            "#{k}=#{v}"
          end
        end.tap { |x| puts x })

        keys.map { |key| self.new(key) }
      end
  end
end