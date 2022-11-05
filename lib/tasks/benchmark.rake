namespace :benchmark do
  desc "Benchmark key generator speed"
  task key_generator: :environment do
    puts Benchmark.measure {
      100_000.times do
        KeyGeneratorService.call
      end
    }
  end
end
