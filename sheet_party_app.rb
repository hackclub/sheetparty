require 'sinatra'
require 'dotenv/load'
require "google/apis/sheets_v4"
require "googleauth"

class SheetPartyApp < Sinatra::Base
  client = Google::Apis::SheetsV4::SheetsService.new
  client.authorization = Google::Auth::ServiceAccountCredentials.from_env(scope: "https://www.googleapis.com/auth/spreadsheets.readonly")
  
  get '/' do
    data = []
    data[0] = client.get_spreadsheet_values(ENV["SPREADSHEET_ID"], "A2").values
    data[1] = client.get_spreadsheet_values(ENV["SPREADSHEET_ID"], "B2").values
    data[2] = client.get_spreadsheet_values(ENV["SPREADSHEET_ID"], "C2").values
    data[3] = client.get_spreadsheet_values(ENV["SPREADSHEET_ID"], "D2").values
  
  
    liquid :index, :locals => { 
      :html => data[0], 
      :css => data[1], 
      :js => data[2], 
      :importmap => data[3]
    }
  end
end
