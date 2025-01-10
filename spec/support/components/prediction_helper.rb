module Components
  module PredictionHelper
    def health_guidance(type, level)
      file = File.read("app/assets/guidance/health_guidance.json")
      data_hash = JSON.parse(file, symbolize_names: true)
      data_hash[type][level]
    end
  end
end
