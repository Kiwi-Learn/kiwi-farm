Dir.glob('./{models,helpers,controllers,forms,services}/*.rb').each { |file| require file }

run ApplicationController
